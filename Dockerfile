###########################################################
#
# Base Images:
#
# https://github.com/tiangolo/uvicorn-gunicorn-docker
#     |
#     |--> https://github.com/tiangolo/uvicorn-gunicorn-fastapi-docker
#
###########################################################

FROM python:3.11

LABEL maintainer="Ismet Handzic <ismet.handzic@gmail.com"
LABEL description="FastAPI server"

RUN apt update && apt install -y --no-cache \
  pipenv \
  vim \
  fzf
RUN pip install --upgrade pip

COPY ./start.sh /start.sh
RUN chmod +x /start.sh
COPY ./start-reload.sh /start-reload.sh
RUN chmod +x /start-reload.sh

COPY ./gunicorn_conf.py /gunicorn_conf.py

COPY Pipfile* /
RUN pipenv requirements > /requirements.txt
RUN pip install --no-cache-dir -r /requirements.txt

COPY ./app /app

ENV PYTHONPATH=/app
ENV PORT=8000
ENV MAX_WORKERS=3

EXPOSE 8000

# move files in .continer into home directory
COPY ./.container/* /root/

CMD ["/start.sh"]
