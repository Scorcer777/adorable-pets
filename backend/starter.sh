#!/bin/sh

while ! nc -z db 5432;
    do sleep .5;
    echo "wait database";
done;
    echo "connected to the database";

python manage.py makemigrations
python manage.py migrate
gunicorn -w 2 -b 0:9000 kittygram_backend.wsgi:application