from fastapi import APIRouter
from fastapi import APIRouter, Body
from pydantic import BaseModel
from typing import Optional
from database.connection import tasks_collection
from bson import ObjectId

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

'''@router.get("/")
def list_tasks(category: Optional[str] = None):
    query = {}
    if category:
        query["category"] = category
    tasks = []
    for task in tasks_collection.find(query):
        task["_id"] = str(task["_id"])
        tasks.append(task)
    return tasks
'''
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

import random

@router.get("/featured")
def get_featured_tasks():
    all_tasks = list(tasks_collection.find())
    for task in all_tasks:
        task["_id"] = str(task["_id"])
    return random.sample(all_tasks, min(3, len(all_tasks)))  # return 3 random tasks



# Endpoint to allow a task seeker to accept a task
@router.put("/accept/{task_id}")
def accept_task(task_id: str, assigned_to: str = Body(..., embed=True)):
    """Assign a task to a seeker (accept the task)."""
    try:
        obj_id = ObjectId(task_id)
    except:
        return {"error": "Invalid task ID format"}

    result = tasks_collection.update_one(
        {"_id": obj_id, "assigned_to": ""},
        {"$set": {"assigned_to": assigned_to}}
    )
    if result.modified_count == 1:
        return {"message": "Task accepted successfully"}
    return {"error": "Task not found or already assigned"}