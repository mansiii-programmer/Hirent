import random
import os
from dotenv import load_dotenv
from email.message import EmailMessage
import aiosmtplib

load_dotenv()

otp_store = {}  # { email: (otp, expiry_timestamp) }

def generate_otp():
    return str(random.randint(100000, 999999))

async def send_otp_email(to_email: str, otp: str):
    msg = EmailMessage()
    msg["From"] = os.getenv("EMAIL_USERNAME")
    msg["To"] = to_email
    msg["Subject"] = "Your OTP for Hirent"
    msg.set_content(f"Your OTP is: {otp}\nIt will expire in 5 minutes.")

    await aiosmtplib.send(
        msg,
        hostname=os.getenv("EMAIL_HOST"),
        port=int(os.getenv("EMAIL_PORT")),
        start_tls=True,
        username=os.getenv("EMAIL_USERNAME"),
        password=os.getenv("EMAIL_PASSWORD"),
    )