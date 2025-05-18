# auth/routes.py

from fastapi import APIRouter, HTTPException
from datetime import datetime
from .schema import UserSignup, UserLogin, TokenResponse
from database.connection import users_collection, hash_pw, verify_pw
from .utils import create_token
from datetime import datetime, timedelta
from otp.otp_utils import generate_otp, send_otp_email, otp_store

router = APIRouter()
async def send_otp(email):
    otp = generate_otp()
    expiry = datetime.utcnow() + timedelta(minutes=5)
    otp_store[email] = (otp, expiry)
    await send_otp_email(email, otp)
    return {"message": "OTP sent to your email"}

@router.post("/signup", status_code=201)
async def signup(user: UserSignup):
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
    await send_otp(new_user["email"])
    
    return {"message": "User created successfully"}

@router.post("/login")
def login(user: UserLogin):
    db_user = users_collection.find_one({"email": user.email})
    if not db_user or not verify_pw(user.password, db_user["password_hash"]):
        raise HTTPException(status_code=401, detail="Invalid credentials")

    token = create_token({"sub": db_user["email"], "role": db_user["role"]})

    return {
        "access_token": token,
        "token_type": "bearer",
        "user": {
            "email": db_user["email"],
            "role": db_user["role"]
        }
    }
