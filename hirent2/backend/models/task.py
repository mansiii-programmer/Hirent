from pydantic import BaseModel
from typing import Optional

class Task(BaseModel):
    title: str
    description: str
    category: str
    posted_by: str  # user id
    assigned_to: Optional[str]