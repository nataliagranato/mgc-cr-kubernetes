FROM python:3.13.2-alpine

WORKDIR /app

COPY ./app /app

RUN pip install fastapi uvicorn

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "5000"]
