# FastAPI Template Project

Starter project for any FastAPI backend REST API applications.  This project is used with Docker.

## Usage

```bash
docker compose up --build
```

```bash
docker build --tag app
docker run --env-file .env --publish 8000:8000 app
```

## Development

```bash
docker build --tag app
docker run --env-file .env --publish 8000:8000 --volume $(pwd):/app app /start-reload.sh
```
