from fastapi import APIRouter, HTTPException
from models.user import User
from database.connection import db

router = APIRouter()

@router.post("/register")
async def register_user(user: User):
    existing = await db.users.find_one({"email": user.email})
    if existing:
        raise HTTPException(status_code=400, detail="User already exists")
    await db.users.insert_one(user.dict())
    return {"message": "User registered successfully"}