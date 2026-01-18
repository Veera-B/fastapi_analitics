from pydantic import BaseModel
from typing import List

class EventSchema(BaseModel):
    id: int


class EventsListSchema(BaseModel):
    result: List[EventSchema]