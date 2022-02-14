from typing import List, Optional
from fastapi import FastAPI, HTTPException
import requests
from models import User
from decouple import config
import itertools

API_KEY = config('GH_TOKEN')

app = FastAPI()

db: List[User] = [
    User(
        login="ebraimcarvalho",
        contributions=5
    ),
    User(
        login="ebraimcarvalho",
        contributions=10
    )
]

def get_request_api_github(link):
    return requests.get(link, headers={'Authorization': f'token {API_KEY}'})

@app.get('/org/{org_name}/contributors')
async def get_contributors(org_name: str):
    link_organization = f"https://api.github.com/users/{org_name}/repos"
    repos = get_request_api_github(link_organization)
    if repos.status_code == 200:
        data = repos.json()
        for repo in data:
            link_repo = f"https://api.github.com/repos/{org_name}/{repo['name']}/contributors"
            contributions = get_request_api_github(link_repo)
            if contributions.status_code == 200:
                response = contributions.json()
                for contrib in response:
                    db.append(
                        User(
                            login=contrib['login'],
                            contributions=contrib['contributions']
                        ))
        mapping = [(user.login, user.contributions) for user in db]
        mapping.sort(key=lambda x:x[0])
        result = [(key, sum(num for _, num in value))
            for key, value in itertools.groupby(mapping, lambda x: x[0])]
        result.sort(key=lambda x:x[1], reverse=True)
        output = []
        for item in result:
            output.append({
                'login': item[0],
                'contributions': item[1]
            })
        return output
    return {
        'erro': org_name
    }

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