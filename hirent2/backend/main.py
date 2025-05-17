from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routers.user_routes import user_router
from dotenv import load_dotenv
load_dotenv()  # call this as early as possible


# Routers
from auth.routes import router as auth_router
from chat.chat_routes import router as chat_router
from otp.otp_routes import router as otp_router
from routers.tasks import router as task_router
from routers.sbert_service import router as sbert_router
from routers.changepassword.routes import router as changepassword_router

# Initialize app
app = FastAPI()
origins = [
    "http://localhost",
    "http://127.0.0.1",
    "http://10.0.2.2",            # android emulator proxy
    "http://192.168.1.10",        # replace with your laptop IP
    "http://192.168.1.10:8000",   # with port if needed
    # add other origins as required
]

# Enable CORS
app.add_middleware(
    CORSMiddleware,
   allow_origins=origins,  # In production, restrict this to frontend domain
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

