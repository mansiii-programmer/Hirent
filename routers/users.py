from fastapi import APIRouter
from models.user import User

router = APIRouter(
    prefix="/users",
    tags=["users"]
)

fake_users = []

@router.post("/")
def create_user(user: User):
    fake_users.append(user)
    return {"msg": "User created", "user": user}