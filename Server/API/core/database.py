from sqlalchemy import create_engine, Column, Integer, String, DateTime, ForeignKey, Boolean
from sqlalchemy.orm import relationship
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker
from decouple import config

Base = declarative_base()

class User(Base):
    __tablename__ = 'usuarios'

    userID = Column(Integer, primary_key=True)
    nombre = Column(String)
    correo = Column(String, unique=True)
    hashed_password = Column(String)

    ejes = relationship('Ejes', back_populates='usuario')
    entradas = relationship('Entradas', back_populates='usuario')
    seguimiento = relationship('Seguimiento', back_populates='usuario')

class Entradas(Base):
    __tablename__ = 'entradas'

    entradaID = Column(Integer, primary_key=True)
    userID = Column(Integer, ForeignKey('usuarios.userID'))
    ejeID = Column(Integer, ForeignKey('ejes.ejeID'))
    fecha_realizacion = Column(DateTime)
    puntaje = Column(Integer)
    diagnostico = Column(String)

    usuario = relationship('User', back_populates='entradas')
    eje = relationship('Ejes', back_populates='entradas')
    seguimiento = relationship('Seguimiento', back_populates='entrada')


class PreguntasEjes(Base):
    __tablename__ = 'preguntas_eje'

    preguntaID = Column(Integer, primary_key=True)
    texto_pregunta = Column(String)
    ejeID = Column(Integer, ForeignKey('ejes.ejeID'))

    eje = relationship('Ejes', back_populates='preguntas')


class Seguimiento(Base):
    __tablename__ = 'seguimiento'

    seguimientoID = Column(Integer, primary_key=True)
    userID = Column(Integer, ForeignKey('usuarios.userID'))
    ejeID = Column(Integer, ForeignKey('ejes.ejeID'))
    tareaID = Column(Integer, ForeignKey('tareas.tareaID'))
    completado = Column(Boolean)
    fecha_completado = Column(DateTime)
    entradaID = Column(Integer, ForeignKey('entradas.entradaID'))

    usuario = relationship('User', back_populates='seguimiento')
    eje = relationship('Ejes', back_populates='seguimiento')
    tarea = relationship('Tareas', back_populates='seguimiento')
    entrada = relationship('Entradas', back_populates='seguimiento')


class Tareas(Base):
    __tablename__ = 'tareas'
    tareaID = Column(Integer, primary_key=True)
    descripcion = Column(String)

    seguimiento = relationship('Seguimiento', back_populates='tarea')


class Ejes(Base):
    __tablename__ = 'ejes'

    ejeID = Column(Integer, primary_key=True)
    nombre = Column(String)
    userID = Column(Integer, ForeignKey('usuarios.userID'))

    usuario = relationship('User', back_populates='ejes')
    preguntas = relationship('PreguntasEjes', back_populates='eje')
    seguimiento = relationship('Seguimiento', back_populates='eje')
    entradas = relationship('Entradas', back_populates='eje')


engine = create_engine(config("SQLALCHEMY_DATABASE_URL"), connect_args={"check_same_thread": False})  # Puedes elegir la base de datos que desees

Base.metadata.create_all(engine)
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)