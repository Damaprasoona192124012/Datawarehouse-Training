from sqlalchemy.orm import Session
from . import models, schemas
from datetime import datetime

def get_product(db: Session, product_id: int):
    return db.query(models.ProductDB).filter(models.ProductDB.id == product_id).first()

def get_products(db: Session, skip: int = 0, limit: int = 100):
    return db.query(models.ProductDB).offset(skip).limit(limit).all()

def create_product(db: Session, product: schemas.ProductCreate):
    db_product = models.ProductDB(**product.dict())
    db.add(db_product)
    db.commit()
    db.refresh(db_product)
    return db_product

def update_product(db: Session, product_id: int, product: schemas.ProductBase):
    db_product = db.query(models.ProductDB).filter(models.ProductDB.id == product_id).first()
    if not db_product:
        return None
    
    update_data = product.dict(exclude_unset=True)
    for field, value in update_data.items():
        setattr(db_product, field, value)
    
    db_product.updated_at = datetime.utcnow().isoformat()
    db.commit()
    db.refresh(db_product)
    return db_product

def delete_product(db: Session, product_id: int):
    db_product = db.query(models.ProductDB).filter(models.ProductDB.id == product_id).first()
    if not db_product:
        return False
    
    db.delete(db_product)
    db.commit()
    return True

def get_products_by_category(db: Session, category: models.ProductCategory):
    return db.query(models.ProductDB).filter(models.ProductDB.category == category).all()

def get_available_products(db: Session):
    return db.query(models.ProductDB).filter(models.ProductDB.is_available == True).all()
