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
    )
]

def get_request_api_github(link):
    return requests.get(link, headers={'Authorization': f'token {API_KEY}'})

def map_values_db_in_tuples_sorted_by_login():
    mapping = [(user.login, user.contributions) for user in db]
    mapping.sort(key=lambda x:x[0])
    return mapping

def group_by_login_sum_contributions(mapping):
    result = [(key, sum(num for _, num in value))
        for key, value in itertools.groupby(mapping, lambda x: x[0])]
    result.sort(key=lambda x:x[1], reverse=True)
    return result

def generate_output(result):
    output = []
    for item in result:
        output.append({
            'login': item[0],
            'contributions': item[1]
        })
    return output

@app.get('/org/{org_name}/contributors')
async def get_contributors(org_name: str):
    db.clear()
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
            else:
               raise HTTPException(
                status_code=404,
                detail=f"Repository {repo['name']} from organization {org_name} can't be accessed"
            ) 
        mapping = map_values_db_in_tuples_sorted_by_login()
        result = group_by_login_sum_contributions(mapping)
        output = generate_output(result)
        return output
    return {
        'erro': f"{org_name} can't be accessed! Please, check if this organization has a github account."
    }

@app.get('/')
async def hello():
    return {
        "Hello": "World!",
        "Scalac": "Challenge"
    }

@app.get('/get_users')
async def get_users():
    mapping = map_values_db_in_tuples_sorted_by_login()
    result = group_by_login_sum_contributions(mapping)
    output = generate_output(result)
    return output

@app.post('/create_user/')
async def get_users(user: User):
    db.append(user)
    return user

@app.delete('/users/{user_login}')
async def delete_user(user_login: str):
    for user in db:
        if user_login == user.login:
            db.remove(user)
            return {'msg': "User deleted"}
    raise HTTPException(
        status_code=404,
        detail=f"User with login {user_login} does not exists!"
    )

@app.get('/users/{user_login}')
def get_item(user_login: str, name: Optional[str] = None):
    return {
        "user_login": user_login,
        "name": name
    }

@app.put('/users/{user_login}')
def update_user(user_login: str, user_update: User):
    for user in db:
        if user_login == user.login:
            if user_update.login is not None:
                user.login = user_update.login
            if user_update.contributions is not None:
                user.contributions = user_update.contributions
            return {'msg': "User updated!"}
    raise HTTPException(
        status_code=404,
        detail=f"User with login {user_login} does not exists!"
    )
