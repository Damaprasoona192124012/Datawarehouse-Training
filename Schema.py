from typing import Optional
from enum import Enum
from pydantic import BaseModel, Field, validator
from datetime import datetime

class ProductCategory(str, Enum):
    ELECTRONICS = "electronics"
    CLOTHING = "clothing"
    BOOKS = "books"
    HOME = "home"
    SPORTS = "sports"
    OTHER = "other"

class ProductBase(BaseModel):
    name: str = Field(..., min_length=1, max_length=100)
    description: Optional[str] = Field(None, max_length=500)
    price: float = Field(..., gt=0)
    category: ProductCategory
    in_stock: int = Field(..., ge=0)
    image_url: Optional[str] = None
    discount: Optional[float] = Field(0.0, ge=0, le=1)

    @validator('price')
    def price_must_be_positive(cls, v):
        if v <= 0:
            raise ValueError('Price must be positive')
        return v

    @validator('in_stock')
    def stock_must_be_non_negative(cls, v):
        if v < 0:
            raise ValueError('Stock cannot be negative')
        return v

class ProductCreate(ProductBase):
    pass

class ProductResponse(ProductBase):
    id: int
    is_available: bool
    created_at: str
    updated_at: str
    discounted_price: Optional[float] = None

    class Config:
        orm_mode = True
