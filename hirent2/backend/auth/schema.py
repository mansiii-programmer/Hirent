# auth/schema.py

from pydantic import BaseModel, EmailStr
from typing import Optional

class UserSignup(BaseModel):
    username: str
    email: EmailStr
    password: str
    role: str
    phone: str
    location: str
    profile_picture: Optional[str] = ""
    bio: Optional[str] = ""

class UserLogin(BaseModel):
    email: EmailStr
    password: str

class TokenResponse(BaseModel):
    access_token: str
    token_type: str