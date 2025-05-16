# auth/routes.py

from fastapi import APIRouter, HTTPException
from datetime import datetime
from .schema import UserSignup, UserLogin, TokenResponse
from database.connection import users_collection, hash_pw, verify_pw
from .utils import create_token

router = APIRouter()

@router.post("/signup", status_code=201)
def signup(user: UserSignup):
    if users_collection.find_one({"email": user.email}):
        raise HTTPException(status_code=400, detail="Email already registered")

    new_user = {
        "username": user.username,
        "email": user.email,
        "password_hash": hash_pw(user.password),
        "role": user.role,
        "phone": user.phone,
        "location": user.location,
        "tasks_posted": [],
        "tasks_assigned": [],
        "profile_picture": user.profile_picture,
        "bio": user.bio,
        "created_at": datetime.utcnow().isoformat()
    }

    users_collection.insert_one(new_user)
    return {"message": "User created successfully"}

@router.post("/login", response_model=TokenResponse)
def login(user: UserLogin):
    db_user = users_collection.find_one({"email": user.email})
    if not db_user or not verify_pw(user.password, db_user["password_hash"]):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    token = create_token({"sub": db_user["email"], "role": db_user["role"]})
    return {"access_token": token, "token_type": "bearer"}