### How to run this project

1. Clone this repository
2. Install the requirements `pip install -r requirements.txt`
3. Create a .env file with your github access token and set `GH_TOKEN=<Your Token Here>`
4. Move to app folder and run `uvicorn main:app --reload --port 8080`
5. Open your browser and type: http://127.0.0.1:8080/docs to view the endpoints and make some requests
6. If your access the address http://127.0.0.1:8080/org/dadosfera/contributors you will see a list of objects sorted by number of contributions made in all repositories of a company called dadosfera.

*Check if the company name that you will replace in address have a github account!*

### Image example


- Api Working with example organization Dadosfera

<img title="Endpoints Documentation" alt="Image example api working" src="assets/get_contributions_dadosfera.JPG">


- Documentation with endpoints and interactive mode

<img title="Endpoints Documentation" alt="Endpoints Documentation" src="assets/api_docs.jpeg">