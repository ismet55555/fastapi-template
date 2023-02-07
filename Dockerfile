###########################################################
#
# This is based on the following work:
#  - https://github.com/tiangolo/uvicorn-gunicorn-docker
#  - https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker
#
###########################################################

FROM python:3.11

LABEL maintainer="Ismet Handzic <ismet.handzic@gmail.com"
LABEL description="FastAPI server"

RUN apt-get update && apt-get -q install -y \
  vim \
  && rm -rf /var/lib/apt/lists/* \
  && apt-get clean
RUN pip install --upgrade pip pipenv

COPY ./start.sh /start.sh
RUN chmod +x /start.sh
COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

COPY Pipfile* /
RUN pipenv --version
RUN pipenv --help
RUN pipenv requirements > /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

COPY ./app /app

ENV PYTHONPATH=/app
ENV PORT=8000
ENV MAX_WORKERS=3

EXPOSE 8000

RUN useradd -ms /bin/bash appuser

COPY --chown=root:root ./.container/ /root/
COPY --chown=appuser:appuser ./.container/ /home/appuser/

RUN ls -la /root/
RUN ls -la /home/appuser/

USER appuser


CMD ["/start.sh"]
