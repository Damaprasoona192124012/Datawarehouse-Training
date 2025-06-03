from fastapi import FastAPI
from .database import engine, Base
from . import models
from .routes import router

models.Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="E-Commerce Product Management System",
    description="API for managing e-commerce products",
    version="1.0.0"
)

app.include_router(router, prefix="/api/v1")

@app.on_event("startup")
async def startup():
    # Create all database tables
    Base.metadata.create_all(bind=engine)
