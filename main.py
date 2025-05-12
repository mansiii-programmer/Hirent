from fastapi import FastAPI
from routers import users  # Import your router module

app = FastAPI()

app.include_router(users.router)

@app.get("/")
def read_root():
    return {"message": "Hirent Backend API is running"}