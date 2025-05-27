from pydantic import BaseModel, Field
from typing import Optional
from datetime import datetime

class ChatMessage(BaseModel):
    sender: str  # This will be the user's _id as a string
    receiver: str  # This will be the user's _id as a string
    message: str
    timestamp: Optional[datetime] = Field(default_factory=datetime.utcnow)
    is_read: Optional[bool] = False