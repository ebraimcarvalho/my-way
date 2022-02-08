FROM python:3.8

WORKDIR /blu

COPY requirements.txt .

RUN pip install -r requirements.txt

COPY . .

CMD ["python", "./app/main.py"]