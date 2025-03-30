from sqlmodel import SQLModel, Field
from pydantic import BaseModel

class DbUser(SQLModel, table=True):
    id: int = Field(default=None, primary_key=True)
    Username: str = Field(index=True)
    email: str = Field(index=True)
    hashed_pass: bytes

class reg_user(BaseModel):
    Username: str
    email: str
    password: str

class log_user(BaseModel):
    email: str
    password: str
