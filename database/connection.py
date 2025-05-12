# database/connection.py

import pymongo
import os
from dotenv import load_dotenv
from passlib.context import CryptContext

load_dotenv()

mongo_uri = os.getenv("MONGO_URI")
if not mongo_uri:
    raise ValueError("MONGO_URI not found in .env")

client = pymongo.MongoClient(mongo_uri)
db = client["hirent"]

users_collection = db["users"]
tasks_collection = db["tasks"]

pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_pw(password):
    return pwd_context.hash(password)

def verify_pw(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)