FROM python:3.6-alpine

# These commands will copy all the files from the current directory
# to the/app directory, and then make /app directory as our current working directory.
COPY . /app
WORKDIR /app

# since we are using the alpine version of python which does not include the libs which Sqlalchemy requires, in order to run Sqlalchemy we have to install its dependencies, these commands will do that for us.
RUN \
 apk add --no-cache bash && \
 apk add --no-cache postgresql-libs && \
 apk add --no-cache --virtual .build-deps gcc musl-dev postgresql-dev

# run pip to install application dependencies from requirements.txt file.
RUN pip install -r requirements.txt

# This command will expose our application at 5000 port,
# which we will be using to access our application inside the container.
EXPOSE 5000

# Gunicorn is a production server for flask applications.
# entrypoint.sh file which does a very simple task, which is running the Guncorn server.
CMD ["/bin/bash", "entrypoint.sh"]

# we will not be building a docker image for Postgres as we will pull Postgres image from docker hub
