from fastapi import APIRouter, Depends, HTTPException, status, Query, Path
from typing import List, Optional
from sqlalchemy.orm import Session
from . import schemas, crud, models
from .database import get_db

router = APIRouter()

@router.post("/products/", response_model=schemas.ProductResponse, status_code=status.HTTP_201_CREATED)
def create_product(product: schemas.ProductCreate, db: Session = Depends(get_db)):
    db_product = crud.create_product(db, product=product)
    if not db_product:
        raise HTTPException(status_code=400, detail="Product creation failed")
    
    response_product = schemas.ProductResponse.from_orm(db_product)
    response_product.discounted_price = db_product.price * (1 - db_product.discount)
    return response_product

@router.get("/products/", response_model=List[schemas.ProductResponse])
def read_products(
    skip: int = 0,
    limit: int = Query(10, le=100),
    category: Optional[models.ProductCategory] = None,
    available_only: bool = False,
    db: Session = Depends(get_db)
):
    if category and available_only:
        products = crud.get_products_by_category(db, category=category)
        products = [p for p in products if p.is_available]
    elif category:
        products = crud.get_products_by_category(db, category=category)
    elif available_only:
        products = crud.get_available_products(db)
    else:
        products = crud.get_products(db, skip=skip, limit=limit)
    
    response_products = []
    for product in products:
        response_product = schemas.ProductResponse.from_orm(product)
        response_product.discounted_price = product.price * (1 - product.discount)
        response_products.append(response_product)
    
    return response_products

@router.get("/products/{product_id}", response_model=schemas.ProductResponse)
def read_product(product_id: int = Path(..., title="The ID of the product to retrieve"), db: Session = Depends(get_db)):
    db_product = crud.get_product(db, product_id=product_id)
    if db_product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    
    response_product = schemas.ProductResponse.from_orm(db_product)
    response_product.discounted_price = db_product.price * (1 - db_product.discount)
    return response_product

@router.put("/products/{product_id}", response_model=schemas.ProductResponse)
def update_product(product_id: int, product: schemas.ProductBase, db: Session = Depends(get_db)):
    db_product = crud.update_product(db, product_id=product_id, product=product)
    if db_product is None:
        raise HTTPException(status_code=404, detail="Product not found")
    
    response_product = schemas.ProductResponse.from_orm(db_product)
    response_product.discounted_price = db_product.price * (1 - db_product.discount)
    return response_product

@router.delete("/products/{product_id}", status_code=status.HTTP_204_NO_CONTENT)
def delete_product(product_id: int, db: Session = Depends(get_db)):
    success = crud.delete_product(db, product_id=product_id)
    if not success:
        raise HTTPException(status_code=404, detail="Product not found")
    return None

@router.get("/products/available/", response_model=List[schemas.ProductResponse])
def read_available_products(db: Session = Depends(get_db)):
    products = crud.get_available_products(db)
    response_products = []
    for product in products:
        response_product = schemas.ProductResponse.from_orm(product)
        response_product.discounted_price = product.price * (1 - product.discount)
        response_products.append(response_product)
    return response_products
