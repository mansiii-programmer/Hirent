import pymongo
import os
from dotenv import load_dotenv
from passlib.context import CryptContext

# Load environment variables from .env file
load_dotenv()

# Get MongoDB URI from .env
mongo_uri = os.getenv("MONGO_URI")
if not mongo_uri:
    raise ValueError("MONGO_URI not found in .env")

# Initialize MongoDB client and select database
client = pymongo.MongoClient(mongo_uri)
db = client["hirent"]

# Define MongoDB collections
users_collection = db["users"]
tasks_collection = db["tasks"]
messages_collection = db["messages"]

# Password hashing context using bcrypt
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def hash_pw(password: str) -> str:
    """Hash the given plain password using bcrypt."""
    return pwd_context.hash(password)

def verify_pw(plain_password: str, hashed_password: str) -> bool:
    """Verify a plain password against its hashed version."""
    return pwd_context.verify(plain_password, hashed_password)