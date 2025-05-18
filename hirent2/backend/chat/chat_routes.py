from fastapi import APIRouter, HTTPException
from chat.chat_schema import ChatMessage
from database.connection import messages_collection
from typing import List
from pymongo import DESCENDING

router = APIRouter()

@router.post("/chat/send")
def send_message(msg: ChatMessage):
    result = messages_collection.insert_one(msg.dict())
    if result.inserted_id:
        return {"message": "Message sent"}
    raise HTTPException(status_code=500, detail="Message sending failed")

@router.get("/chat/history/{user1}/{user2}", response_model=List[ChatMessage])
def get_chat_history(user1: str, user2: str):
    history = list(messages_collection.find({
        "$or": [
            {"sender": user1, "receiver": user2},
            {"sender": user2, "receiver": user1}
        ]
    }).sort("timestamp", DESCENDING))

    # Convert ObjectId to string and timestamp to ISO
    for msg in history:
        msg["_id"] = str(msg["_id"])
        msg["timestamp"] = msg["timestamp"].isoformat()
    return history