from fastapi import FastAPI
from api.events import router as events_router

app = FastAPI()

app.include_router(events_router, prefix="/api")
#REST API ENDPOINTS
@app.get("/")
async def root():
    return {"message": "Hello super !"}
@app.get("/get-data")
async def get_data():
    return {"message": "veera you did greate job!"}