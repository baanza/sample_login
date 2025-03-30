from fastapi import FastAPI
from fastapi.responses import RedirectResponse
from models import *
from dbase import create_all
from auth import router

app = FastAPI()

@app.on_event("startup")
def starting():
    create_all()

app.include_router(router=router)

@app.get("/")
def home():
    return RedirectResponse("https://google.com")
