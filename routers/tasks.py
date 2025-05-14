from fastapi import APIRouter
from pydantic import BaseModel
from typing import Optional
from database.connection import tasks_collection

router = APIRouter()

# Task model
class Task(BaseModel):
    title: str
    description: Optional[str]
    category: str
    posted_by: Optional[str] = None
    assigned_to: Optional[str] = None

# Static task categories
TASK_CATEGORIES = [
    "Food Delivery", "Gardening", "Plumbing",
    "Assignment Help", "Pet Walk", "More Tasks"
]

@router.get("/categories")
def get_categories():
    """Return predefined task categories for frontend grid."""
    return {"categories": TASK_CATEGORIES}

@router.post("/")
def create_task(task: Task):
    """Create a new task. Auth is disabled for now."""
    if not task.posted_by:
        task.posted_by = "test-user-id"
    result = tasks_collection.insert_one(task.dict())
    return {"message": "Task created", "task_id": str(result.inserted_id)}

@router.get("/")
def list_tasks():
    """Return all tasks from the database."""
    tasks = []
    for task in tasks_collection.find():
        task["_id"] = str(task["_id"])
        tasks.append(task)
    return tasks