fake_users = {
    "test@gmail.com": {
        "email": "test@gmail.com",
        "password": "test123"  # Normally hashed
    }
}

def verify_user(email: str, password: str):
    user = fake_users.get(email)
    if user and user["password"] == password:
        return True
    return False