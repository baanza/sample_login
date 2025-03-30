from fastapi import APIRouter, Depends, HTTPException, status

from dbase import yield_session
from typing import Annotated
from models import *
from sqlmodel import Session, select
import bcrypt
from email_validator import validate_email, EmailNotValidError

sesh = Annotated[Session, Depends(yield_session)]

router = APIRouter(prefix="/auth")

@router.post("/register/", tags=["auth"])
def register(user: reg_user , session: sesh):
    statement = select(DbUser).where(DbUser.email == user.email)
    res = session.exec(statement).first()
    if res:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="User already exists please login")
    else:
        try:
            valid_email = validate_email(user.email, check_deliverability=True)
        except EmailNotValidError as e:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail= str(e)
            )

        hashed_password = bcrypt.hashpw(user.password.encode(), bcrypt.gensalt())
        session.add(DbUser(Username= user.Username, email=valid_email.normalized, hashed_pass=hashed_password))
        session.commit()

    return {
        "status": "user added",
        "code": status.HTTP_201_CREATED
    }

@router.post("/login/", tags=["auth"])
def login(user: log_user, session: sesh):
    statement = select(DbUser).where(DbUser.email == user.email)
    res = session.exec(statement).first()
    if not res:
        raise HTTPException(
            status_code=status.HTTP_404_NOT_FOUND,
            detail= "User Not found"
        )
    else:
        ps = bcrypt.checkpw(user.password.encode(), res.hashed_pass)
        
        if not ps:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Wrong Password"
            )
        else:
            return {
                "status": status.HTTP_200_OK,
                "username": res.Username,
            }