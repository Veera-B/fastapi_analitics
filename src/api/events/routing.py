
from fastapi import APIRouter
from .Schemas import EventSchema, EventsListSchema
import os

router = APIRouter()
# api/events/routing.py

@router.get("/events")
async def get_events():
    print(os.environ.get("DATABASE_URL"))
    return {"message": [1,2,3]}

@router.get("/events/{event_id}")
async def getEventId(event_id: int) -> EventSchema:
    return {"id": event_id}

@router.get("/events_list", response_model=EventsListSchema)
async def get_events_list() -> EventsListSchema:
    events = [{"id": 1}, {"id": 2}, {"id": 3}]
    return EventsListSchema(result=events)  