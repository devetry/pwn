FROM ubuntu:18.04 as poetry

MAINTAINER Brian Schiller "brian@devetry.com"

RUN apt-get update -y && apt-get install -y python3 python3-pip python3-venv
RUN pip3 install poetry

# We copy just the requirements.txt first to leverage Docker cache
COPY ./pyproject.toml /app/pyproject.toml

WORKDIR /app

RUN poetry install
RUN poetry export -f requirements.txt -o requirements.txt

FROM ubuntu:18.04
RUN apt-get update -y && apt-get install -y python3 python3-pip
WORKDIR /app
COPY --from=poetry /app/requirements.txt .
RUN pip3 install -r requirements.txt
COPY . /app
ENV PORT=80
EXPOSE 80
ENTRYPOINT [ "gunicorn" ]
CMD [ "-w", "4", "src.app:app" ]
