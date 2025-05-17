from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional
from bson import ObjectId
from database.connection import users_collection

user_router = APIRouter()

# ----------- MODELS ----------- #
class UserUpdate(BaseModel):
    username: Optional[str] = None
    phone: Optional[str] = None
    bio: Optional[str] = None

class PreferencesUpdate(BaseModel):
    language: Optional[str] = None
    notifications_enabled: Optional[bool] = None

# ----------- ROUTES ----------- #

@user_router.get("/users/{user_id}")
def get_user_profile(user_id: str):
    try:
        user = users_collection.find_one({"_id": ObjectId(user_id)})
        if not user:
            raise HTTPException(status_code=404, detail="User not found")
        user["_id"] = str(user["_id"])
        return user
    except:
        raise HTTPException(status_code=400, detail="Invalid user ID")

@user_router.put("/users/{user_id}")
def update_user_profile(user_id: str, data: UserUpdate):
    update_data = {k: v for k, v in data.dict().items() if v is not None}
    if not update_data:
        raise HTTPException(status_code=400, detail="No valid fields to update")

    result = users_collection.update_one(
        {"_id": ObjectId(user_id)},
        {"$set": update_data}
    )
    if result.modified_count == 1:
        return {"message": "User updated successfully"}
    raise HTTPException(status_code=404, detail="User not found or unchanged")

@user_router.get("/users/{user_id}/wallet")
def get_wallet_balance(user_id: str):
    user = users_collection.find_one({"_id": ObjectId(user_id)}, {"wallet": 1})
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return {"wallet": user.get("wallet", 0)}

@user_router.get("/users/{user_id}/payment-methods")
def get_payment_methods(user_id: str):
    user = users_collection.find_one({"_id": ObjectId(user_id)}, {"payment_methods": 1})
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return {"payment_methods": user.get("payment_methods", [])}

@user_router.put("/users/{user_id}/preferences")
def update_preferences(user_id: str, prefs: PreferencesUpdate):
    result = users_collection.update_one(
        {"_id": ObjectId(user_id)},
        {"$set": prefs.dict(exclude_none=True)}
    )
    if result.modified_count == 1:
        return {"message": "Preferences updated"}
    raise HTTPException(status_code=404, detail="User not found or unchanged")