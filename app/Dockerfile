FROM python:3.11-slim

WORKDIR /app

COPY flaskr /app/flaskr
COPY requirements.txt /app/
COPY pyproject.toml /app/

RUN pip install --no-cache-dir -r requirements.txt

EXPOSE 5000
CMD ["flask", "--app", "flaskr", "run", "--host=0.0.0.0"]

