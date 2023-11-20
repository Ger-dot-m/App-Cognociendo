from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from models import endpoints
from decouple import config

app = FastAPI(
    title=config("PROJECT_NAME"),
    version=config("PROJECT_VERSION"),
)

print(config("FRONTEND_URL"))

origins = [
    config("FRONTEND_URL"),
]

app.add_middleware(
    CORSMiddleware,
    allow_origins=origins,
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Endpoints
app.include_router(endpoints.router, tags=["Users"])

"""
if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="0.0.0.0", port=8000)
"""

# uvicorn main:app --host 0.0.0.0 --port 8000 --reload


