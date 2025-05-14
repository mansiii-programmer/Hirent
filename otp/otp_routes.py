from fastapi import APIRouter, HTTPException
from pydantic import BaseModel, EmailStr
from datetime import datetime, timedelta
from .otp_utils import generate_otp, send_otp_email, otp_store

router = APIRouter()

class OTPRequest(BaseModel):
    email: EmailStr

class OTPVerify(BaseModel):
    email: EmailStr
    otp: str

@router.post("/otp/send")
async def send_otp(req: OTPRequest):
    otp = generate_otp()
    expiry = datetime.utcnow() + timedelta(minutes=5)
    otp_store[req.email] = (otp, expiry)
    await send_otp_email(req.email, otp)
    return {"message": "OTP sent to your email"}

@router.post("/otp/verify")
def verify_otp(req: OTPVerify):
    record = otp_store.get(req.email)
    if not record:
        raise HTTPException(status_code=404, detail="No OTP found")

    otp, expiry = record
    if datetime.utcnow() > expiry:
        raise HTTPException(status_code=400, detail="OTP expired")
    if req.otp != otp:
        raise HTTPException(status_code=401, detail="Incorrect OTP")

    # Optionally: remove OTP after verification
    del otp_store[req.email]
    return {"message": "OTP verified successfully"}