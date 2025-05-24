from pymongo import MongoClient
from sentence_transformers import SentenceTransformer
import numpy as np

# Connect to MongoDB
client = MongoClient("mongodb+srv://dishapancholi2510:dishapancholi_25@cluster0.uqhjw5g.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0")
db = client['hirent']
users = db['users']

# Load model
model = SentenceTransformer('all-MiniLM-L6-v2')

# Get user input
seeker_skills = input("Enter your skills (comma separated): ").strip().split(",")
seeker_interests = input("Enter your interests (comma separated): ").strip().split(",")
seeker_text = " ".join([s.strip() for s in seeker_skills + seeker_interests])
seeker_embedding = model.encode(seeker_text, convert_to_tensor=True).cpu().numpy()

# Store task matches
task_matches = []

# Iterate through providers and their tasks
for provider in users.find({"role": "provider"}):
    for task in provider.get("tasks_posted", []):
        task_text = f"{task.get('title', '')} {task.get('description', '')} {task.get('category', '')}"
        task_embedding = model.encode(task_text, convert_to_tensor=True).cpu().numpy()
        score = float(np.dot(seeker_embedding, task_embedding) / (np.linalg.norm(seeker_embedding) * np.linalg.norm(task_embedding)))

        task_matches.append({
            "provider_name": provider.get("username", "N/A"),
            "task_title": task.get("title"),
            "category": task.get("category"),
            "score": score
        })

# Sort and pick top 4
top_matches = sorted(task_matches, key=lambda x: x["score"], reverse=True)[:4]

# PRINT ONLY TOP 4
print("\nTop 4 Recommended Tasks Based on Your Skills and Interests:")
for match in top_matches:
    print(f"Provider: {match['provider_name']}, Similarity Score: {match['score']:.4f}")
    print(f"  - Task: {match['task_title']} ({match['category']})\n")
