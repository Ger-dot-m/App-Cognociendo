from pydantic import BaseModel, EmailStr
from datetime import datetime
# Modelos
class UserAPI(BaseModel):
    nombre: str
    correo: EmailStr
    contraseña: str

class UserInDB(UserAPI):
    hashed_password: str

class Token(BaseModel):
    access_token: str
    token_type: str

class TokenData(BaseModel):
    userID: int = None
    expire: datetime

class UserLogin(BaseModel):
    correo: EmailStr
    contraseña: str


class EntradaAPI(BaseModel):
    ejeID: int
    puntaje: int
    diagnostico: str

class EntradaResponse(EntradaAPI):
    fecha: datetime

class SeguimientoAPI(BaseModel):
    ejeID: int
    tareaID: int
    completado: bool = False
    entradaID: int


class SeguimientoResponse(SeguimientoAPI):
    """Clase chida"""
    fecha: datetime