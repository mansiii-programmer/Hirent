from fastapi import APIRouter, HTTPException
from chat.chat_schema import ChatMessage
from database.connection import messages_collection
from typing import List
from pymongo import DESCENDING

router = APIRouter()

from bson import ObjectId

@router.post("/chat/send")
def send_message(msg: ChatMessage):
    try:
        sender_id = ObjectId(msg.sender)
        receiver_id = ObjectId(msg.receiver)
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid sender or receiver ID")

    message_doc = {
        "sender": sender_id,
        "receiver": receiver_id,
        "message": msg.message,
        "timestamp": msg.timestamp,
        "is_read": msg.is_read,
    }

    result = messages_collection.insert_one(message_doc)
    if result.inserted_id:
        return {"message": "Message sent"}
    raise HTTPException(status_code=500, detail="Message sending failed")

@router.get("/chat/history/{user1}/{user2}", response_model=List[ChatMessage])
def get_chat_history(user1: str, user2: str):
    try:
        user1_id = ObjectId(user1)
        user2_id = ObjectId(user2)
    except Exception:
        raise HTTPException(status_code=400, detail="Invalid user ID")

    history = list(messages_collection.find({
        "$or": [
            {"sender": user1_id, "receiver": user2_id},
            {"sender": user2_id, "receiver": user1_id}
        ]
    }).sort("timestamp", DESCENDING))

    for msg in history:
        msg["_id"] = str(msg["_id"])
        msg["sender"] = str(msg["sender"])
        msg["receiver"] = str(msg["receiver"])
        msg["timestamp"] = msg["timestamp"].isoformat()
    return history

from bson import ObjectId
from bson.errors import InvalidId

@router.get("/chat/partners/{user_id}")
def get_chat_partners(user_id: str):
    """Return unique users this user has chatted with (using ObjectId)."""
    try:
        user_obj_id = ObjectId(user_id)
    except InvalidId:
        raise HTTPException(status_code=400, detail="Invalid user ID format")

    # Find all messages where user is either sender or receiver
    messages = messages_collection.find({
        "$or": [
            {"sender": user_obj_id},
            {"receiver": user_obj_id}
        ]
    })

    chat_partners = set()

    for msg in messages:
        sender = msg.get("sender")
        receiver = msg.get("receiver")

        if sender != user_obj_id:
            chat_partners.add(str(sender))
        if receiver != user_obj_id:
            chat_partners.add(str(receiver))

    return {"partners": list(chat_partners)}