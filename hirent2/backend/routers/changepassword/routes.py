from fastapi import APIRouter, HTTPException
from datetime import datetime
from otp.otp_utils import otp_store
from database.connection import users_collection, hash_pw
from .models import ResetPasswordWithOTP

router = APIRouter()

@router.post("/changepassword/reset-password")
def reset_password(data: ResetPasswordWithOTP):
    record = otp_store.get(data.email)
    if not record:
        raise HTTPException(status_code=400, detail="OTP not requested or expired")

    otp, expiry = record
    if datetime.utcnow() > expiry:
        raise HTTPException(status_code=400, detail="OTP expired")
    if data.otp != otp:
        raise HTTPException(status_code=401, detail="Incorrect OTP")

    user = users_collection.find_one({"email": data.email})
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    hashed_pw = hash_pw(data.new_password)
    users_collection.update_one(
        {"_id": user["_id"]},
        {"$set": {"password_hash": hashed_pw}}
    )

    del otp_store[data.email]
    return {"message": "Password reset successful"}