# FastAPI Template Project

- Starter project for any FastAPI backend REST API applications
- This server can be used with or without Docker
- By default the server will run on port 8080

## Usage


### Docker 

```bash
docker compose up --build
```

```bash
docker build --tag app
docker run --env-file .env --publish 8080:8080 app
```

### No Docker

```bash
gunicorn -k uvicorn.workers.UvicornWorker -c gunicorn_conf.py app.main:app
```


## Development


### Docker
```bash
docker build --tag app
docker run --env-file .env --publish 8080:8080 --volume $(pwd):/app app /start-reload.sh
```

### No Docker

```bash
uvicorn --reload --host=0.0.0.0 --port 8080 --log-level "info" app.main:app
```
