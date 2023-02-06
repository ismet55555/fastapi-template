###########################################################
#
# Base Images:
#
# https://github.com/tiangolo/uvicorn-gunicorn-docker
#     |
#     |--> https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker
#
###########################################################

# Creating a requriemets.txt file from Pipefile.lock
FROM python:3.11 as requirements-stage

WORKDIR /tmp
RUN pip install pipenv
COPY Pipfile* /tmp/
RUN pipenv requirements > requirements.txt

###########################################################

FROM python:3.11

LABEL maintainer="Ismet Handzic <ismet.handzic@gmail.com"
LABEL description="FastAPI server"

COPY ./start.sh /start.sh
RUN chmod +x /start.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

# Install dependencies with pipenv
RUN pip install --upgrade pip
COPY --from=requirements-stage /tmp/requirements.txt /requirements.txt
RUN pip install --no-cache-dir -r requirements.txt

COPY ./app /app

ENV PYTHONPATH=/app
ENV PORT=8000
ENV MAX_WORKERS=3

EXPOSE 8000

CMD ["/start.sh"]
