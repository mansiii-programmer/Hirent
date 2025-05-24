from pydantic import BaseModel, EmailStr

class ResetPasswordWithOTP(BaseModel):
    email: EmailStr
    otp: str
    new_password: str