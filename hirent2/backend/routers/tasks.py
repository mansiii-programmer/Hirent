from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from database.connection import tasks_collection
from bson import ObjectId
from fastapi import APIRouter, HTTPException, Query, Body
from database.connection import users_collection, tasks_collection
from bson import ObjectId
from bson.errors import InvalidId


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
from datetime import datetime
from bson import ObjectId

@router.post("/")
def create_task(task: Task):
    """Create a new task (for posting from mobile)."""
    if not task.posted_by:
        task.posted_by = "test-user-id"

    result = tasks_collection.insert_one(task.dict())

    # Create a flat task object (as shown in MongoDB screenshot)
    posted_task_info = {
        "title": task.title,
        "description": task.description,
        "category": task.category,
        "location": task.location,
        "created_at": datetime.utcnow().isoformat()
    }

    # Ensure posted_by is ObjectId if stored that way
    user_id = ObjectId(task.posted_by) if ObjectId.is_valid(task.posted_by) else task.posted_by

    # Push to the user's tasks_posted array directly
    users_collection.update_one(
        {"_id": user_id},
        {"$push": {"tasks_posted": posted_task_info}}
    )

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

@router.get("/search")
def search_tasks(q: str):
    query = {
        "$or": [
            {"title": {"$regex": q, "$options": "i"}},
            {"description": {"$regex": q, "$options": "i"}}
        ]
    }
    tasks = []
    for task in tasks_collection.find(query):
        task["_id"] = str(task["_id"])
        tasks.append(task)
    return tasks

# ---------------- Accept Task ---------------- #
@router.put("/accept/{task_id}")
def accept_task(task_id: str, assigned_to: str = Body(..., embed=True)):
    """Assign a task to a seeker (accept the task)."""
    try:
        obj_id = ObjectId(task_id)
    except:
        return {"error": "Invalid task ID format"}

    result = tasks_collection.update_one(
        {"_id": obj_id, "assigned_to": None},
        {"$set": {"assigned_to": assigned_to}}
    )
    print ("result",result)
    
    if result.modified_count == 1:
        # Use assigned_to as a string directly
        users_collection.update_one(
            {"_id": assigned_to},
            {"$push": {"tasks_assigned": str(obj_id)}}
        )
        return {"message": "Task accepted successfully"}
    return {"error": "Task not found or already assigned"}
@router.get("/assigned/{user_id}")
def get_assigned_tasks(user_id: str):
    """Get all tasks assigned to a specific user."""
    tasks = []
    for task in tasks_collection.find({"assigned_to": user_id}):
        task["_id"] = str(task["_id"])
        tasks.append(task)

    if not tasks:
        raise HTTPException(status_code=404, detail="No tasks assigned to this user.")

    return {"assigned_tasks": tasks}

@router.get("/posted/{user_id}")
def get_posted_tasks(user_id: str):
    """
    Get all tasks posted by a specific provider.
    """
    user = users_collection.find_one({"_id": ObjectId(user_id)})

    if not user:
        raise HTTPException(status_code=404, detail="User not found.")

    if user.get("role") != "provider":
        raise HTTPException(status_code=403, detail="User is not a provider.")

    tasks_posted = user.get("tasks_posted", [])
    
    if not tasks_posted:
        raise HTTPException(status_code=404, detail="No tasks posted by this provider.")

    return {"posted_tasks": tasks_posted}