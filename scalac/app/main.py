from typing import List, Optional
from fastapi import FastAPI, HTTPException
from models import User

app = FastAPI()

db: List[User] = [
    User(
        id=1,
        login="ebraimcarvalho", 
        org="Accenture", 
        repo="One Accenture", 
        contributions=5
    )
]

@app.get('/')
async def hello():
    return {
        "Hello": "Worlddd"
    }

@app.get('/get_users')
async def get_users():
    return db

@app.post('/create_user/')
async def get_users(user: User):
    db.append(user)
    return user

@app.delete('/users/{user_id}')
async def delete_user(user_id: int):
    for user in db:
        if user_id == user.id:
            db.remove(user)
            return {'msg': "User deleted"}
    raise HTTPException(
        status_code=404,
        detail=f"User with id {user_id} does not exists"
    )

@app.get('/users/{item_id}')
def get_item(item_id: int, name: Optional[str] = None):
    return {
        "item_id": item_id,
        "name": name
    }