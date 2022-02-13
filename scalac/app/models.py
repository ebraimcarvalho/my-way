from pydantic import BaseModel
from typing import Optional

class User(BaseModel):
    id : int
    login : str
    org : str
    repo : str
    contributions : int
