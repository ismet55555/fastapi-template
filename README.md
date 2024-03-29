# FastAPI Template Project

- Starter project for any FastAPI backend REST API applications
- This server can be used with or without Docker
- By default the server will run on port 8000

TODO:

- Everything into pyproject.toml
- Colorize prompt inside container
- Logging setup

## Usage

### Docker

```bash
docker compose up --build
```

```bash
docker build --tag app
docker run --env-file .env --publish 8000:8000 app
```

### No Docker

```bash
pipenv sync
pipenv run gunicorn -k uvicorn.workers.UvicornWorker -c gunicorn_conf.py app.main:app
```

## Development

### Docker

```bash
docker build --tag app
docker run --env-file .env --publish 8000:8000 --volume $(pwd):/app app /start-reload.sh
```

### No Docker

```bash
pipenv sync --dev
pipenv run uvicorn --reload --host=0.0.0.0 --port 8000 --log-level "info" app.main:app
```
