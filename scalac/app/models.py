from pydantic import BaseModel
from typing import Optional

class User(BaseModel):
    login : str
    contributions : int
