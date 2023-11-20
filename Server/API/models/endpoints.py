from fastapi import APIRouter, HTTPException, Depends
from passlib.context import CryptContext
from jose import jwt
from datetime import datetime, timedelta
from models.models import (UserAPI,
                           UserInDB,
                           EntradaAPI,
                           EntradaResponse,
                           SeguimientoAPI,
                           SeguimientoResponse,
                           Token,
                           TokenData,
                           UserLogin)
from models.dependences import (verify_password,
                                get_current_user,
                                get_password_hash,
                                create_access_token)
from decouple import config
from core.database import User, Entradas, Seguimiento, SessionLocal

router = APIRouter()

# Funciones para trabajar con contraseñas
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

# Rutas
@router.post("/register/", response_model=UserAPI)
async def register(user: UserAPI):
    with SessionLocal() as db:
        if db.query(User).filter_by(correo=user.correo).first():
            raise HTTPException(status_code=400, detail="El usuario ya existe")
        hashed_password = get_password_hash(user.contraseña)
        aux = UserInDB(**user.dict(), hashed_password=hashed_password)
        nuevo_usuario = User(nombre=aux.nombre, correo=aux.correo, hashed_password=aux.hashed_password)
        db.add(nuevo_usuario)
        db.commit()
        db.refresh(nuevo_usuario)
    return user

@router.post("/token/", response_model=Token)
async def login_for_access_token(form_data: UserLogin):
    with SessionLocal() as db:
        user = db.query(User).filter_by(correo=form_data.correo).first()
        if user is None or not verify_password(form_data.contraseña, user.hashed_password ):
            raise HTTPException(status_code=400, detail="Usuario o contraseña incorrectos")

        access_token_expires = timedelta(minutes=int(config("ACCESS_TOKEN_EXPIRE_MINUTES")))
        access_token = create_access_token(data={"sub": str(user.userID)}, expires_delta=access_token_expires)

    return {"id": user.userID, "access_token": access_token, "token_type": "bearer"}


@router.post("/crear_entrada/")
async def crear_entrada(entrada: EntradaAPI, current_user: TokenData = Depends(get_current_user)):
    db =  SessionLocal()
    try:
        nueva_entrada = Entradas(
            userID=current_user.userID,
            ejeID=entrada.ejeID,
            fecha_realizacion=datetime.now(),
            puntaje=entrada.puntaje,
            diagnostico=entrada.diagnostico
        )

        db.add(nueva_entrada)
        db.commit()
        db.refresh(nueva_entrada)

        return {"mensaje": "Entrada creada exitosamente", "entradaID": nueva_entrada.entradaID}

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        db.close()

@router.post("/crear_seguimiento/")
async def crear_seguimiento(entrada: SeguimientoAPI, current_user: TokenData = Depends(get_current_user)):
    db = SessionLocal()
    try:
        nuevo_seguimiento = Seguimiento(
            userID=current_user.userID,
            ejeID=entrada.ejeID,
            tareaID=entrada.tareaID,
            completado=entrada.completado,
            fecha_completado=datetime.now(),
            entradaID=entrada.entradaID
        )
        db.add(nuevo_seguimiento)
        db.commit()
        db.refresh(nuevo_seguimiento)

        return {"mensaje": "Seguimiento creado exitosamente", "seguimientoID": nuevo_seguimiento.seguimientoID}

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        db.close()



@router.get("/read_entries/", response_model=EntradaResponse)
async def read_entries(current_user: TokenData = Depends(get_current_user)):
    db = SessionLocal()
    try:
        data = db.query(Entradas).filter_by(userID=current_user.userID).first()
        return EntradaResponse(ejeID=data.ejeID,
                                  puntaje=data.puntaje,
                                  diagnostico=data.diagnostico,
                                  fecha=data.fecha_realizacion)

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        db.close()


@router.get("/read_tasks/", response_model=SeguimientoResponse)
async def read_entries(current_user: TokenData = Depends(get_current_user)):
    db = SessionLocal()
    try:
        data = db.query(Seguimiento).filter_by(userID=current_user.id).all()
        return SeguimientoResponse(ejeID=data.ejeID,
                                    tareaID=data.tareaID,
                                    completado=data.completado,
                                    entradaID=data.entradaID,
                                    fecha=data.fecha_completado)

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))

    finally:
        db.close()
