from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware

from app.core.config import settings
from app.my_sub_module.something import SomeInterface


def get_application():
    """TODO"""
    _app = FastAPI(title=settings.PROJECT_NAME)

    _app.add_middleware(
        CORSMiddleware,
        allow_origins=[str(origin) for origin in settings.BACKEND_CORS_ORIGINS],
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

    return _app


app = get_application()


@app.get("/")
def read_root():
    """TODO"""
    return {"Hello": "World"}


@app.get("/health")
def health():
    """TODO"""
    return {"status": "healthy"}


@app.get("/status")
def get_status():
    """TODO"""
    my_interface = SomeInterface()
    my_interface.say_hi()
    status = my_interface.some_response()
    return {"status": status, "message": "Everything is cool"}


@app.post("/items/")
def post_item(item: str):
    """TODO"""
    return {"item": item}
