from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers.user_routes import user_router

# Routers
from auth.routes import router as auth_router
from chat.chat_routes import router as chat_router
from otp.otp_routes import router as otp_router
from routers.tasks import router as task_router
from routers.sbert_service import router as sbert_router
from routers.changepassword.routes import router as changepassword_router

# Initialize app
app = FastAPI()

# Enable CORS
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # In production, restrict this to frontend domain
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Register routers
app.include_router(auth_router, prefix="/auth")
app.include_router(chat_router, prefix="/chat")
app.include_router(otp_router, prefix="/otp")
app.include_router(task_router, prefix="/tasks", tags=["Tasks"])
app.include_router(user_router, prefix="/users", tags=["Users"])
app.include_router(sbert_router, tags=["Recommendation"])

