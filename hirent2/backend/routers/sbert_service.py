from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import List
from database.connection import users_collection
from sentence_transformers import SentenceTransformer
import numpy as np

router = APIRouter()
model = SentenceTransformer("all-MiniLM-L6-v2")

# Input model
class SeekerRequest(BaseModel):
    seeker_skills: List[str]
    seeker_interests: List[str]

# Output model
class TaskMatch(BaseModel):
    provider_name: str
    task_title: str
    category: str
    score: float

@router.post("/recommend/tasks", response_model=List[TaskMatch])
def recommend_tasks(data: SeekerRequest):
    seeker_text = " ".join(data.seeker_skills + data.seeker_interests)
    seeker_embedding = model.encode(seeker_text, convert_to_tensor=True).cpu().numpy()

    task_matches = []

    for provider in users_collection.find({"role": "provider"}):
        for task in provider.get("tasks_posted", []):
            task_text = f"{task.get('title', '')} {task.get('description', '')} {task.get('category', '')}"
            task_embedding = model.encode(task_text, convert_to_tensor=True).cpu().numpy()
            score = float(np.dot(seeker_embedding, task_embedding) / (np.linalg.norm(seeker_embedding) * np.linalg.norm(task_embedding)))

            task_matches.append({
                "provider_name": provider.get("username", "N/A"),
                "task_title": task.get("title", ""),
                "category": task.get("category", ""),
                "score": score
            })

    top_matches = sorted(task_matches, key=lambda x: x["score"], reverse=True)[:4]
    return top_matches