from pydantic import BaseModel, EmailStr
from datetime import datetime
from typing import Optional

class ChatMessage(BaseModel):
    sender: EmailStr
    receiver: EmailStr
    message: str
    timestamp: Optional[datetime] = datetime.utcnow()
    is_read: Optional[bool] = False