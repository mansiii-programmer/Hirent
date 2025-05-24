from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database.connection import tasks_collection
from bson import ObjectId

router = APIRouter()

# ---------------- Task Model ---------------- #
class Task(BaseModel):
    title: str
    description: Optional[str]
    category: str
    posted_by: Optional[str] = None
    assigned_to: Optional[str] = None
    amount: Optional[str] = None
    location: Optional[str] = None

# ---------------- Categories ---------------- #
TASK_CATEGORIES = [
    "Cleaning", "Babysitting", "Gardening", "Cooking",
    "Pet Care", "Tutoring", "Delivery", "Shopping"
]

@router.get("/categories")
def get_categories():
    """Return predefined task categories for frontend dropdown."""
    return {"categories": TASK_CATEGORIES}

# ---------------- Create Task ---------------- #
@router.post("/")
def create_task(task: Task):
    """Create a new task (for posting from mobile)."""
    if not task.posted_by:
        task.posted_by = "test-user-id"  # Optional fallback
    result = tasks_collection.insert_one(task.dict())
    return {
        "message": "Task created successfully",
        "task_id": str(result.inserted_id)
    }

# ---------------- List All Tasks ---------------- #
@router.get("/")
def list_tasks():
    """Return all tasks from the database."""
    tasks = []
    for task in tasks_collection.find():
        task["_id"] = str(task["_id"])
        tasks.append(task)
    return tasks