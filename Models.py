from sqlalchemy import Column, Integer, String, Float, Boolean
from sqlalchemy.sql.sqltypes import Enum as SQLEnum
from datetime import datetime
from .database import Base

class ProductCategory(str, Enum):
    ELECTRONICS = "electronics"
    CLOTHING = "clothing"
    BOOKS = "books"
    HOME = "home"
    SPORTS = "sports"
    OTHER = "other"

class ProductDB(Base):
    __tablename__ = "products"
    
    id = Column(Integer, primary_key=True, index=True)
    name = Column(String(100), nullable=False)
    description = Column(String(500))
    price = Column(Float, nullable=False)
    category = Column(SQLEnum(ProductCategory), nullable=False)
    in_stock = Column(Integer, nullable=False)
    is_available = Column(Boolean, default=True)
    created_at = Column(String, default=datetime.utcnow().isoformat())
    updated_at = Column(String, default=datetime.utcnow().isoformat())
    image_url = Column(String, nullable=True)
    discount = Column(Float, default=0.0)
