from models import DbUser
from sqlmodel import SQLModel, create_engine, Session

engine = create_engine("sqlite:///app.db")

def create_all():
    SQLModel.metadata.create_all(engine)

def yield_session():
    with Session(engine) as session:
        try:
            yield session
        finally:
            session.close()