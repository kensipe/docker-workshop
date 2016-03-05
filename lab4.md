# Lab 4: Docker Compose

1. Create an empty project directory.


2. Add the following content to the Dockerfile.

```
FROM python:2.7
ENV PYTHONUNBUFFERED 1
RUN mkdir /code
WORKDIR /code
ADD requirements.txt /code/
RUN pip install -r requirements.txt
ADD . /code/
```

Save and close the Dockerfile.

3. Create a requirements.txt in your project directory.

Add the required software in the file.

```
Django
psycopg2
```

Save and close the requirements.txt file.

4. Create a file called docker-compose.yml in your project directory.

```
version: '2'
services:
  db:
    image: postgres
  web:
    build: .
    command: python manage.py runserver 0.0.0.0:8000
    volumes:
      - .:/code
    ports:
      - "8000:8000"
    depends_on:
      - db
```

Save and close the docker-compose.yml file.

5. Create a Django project

`$ docker-compose run web django-admin.py startproject composeexample .`

6. Connect the database. In your project directory, edit the composeexample/settings.py file.

Replace the DATABASES = ... with the following:

```
DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.postgresql_psycopg2',
        'NAME': 'postgres',
        'USER': 'postgres',
        'HOST': 'db',
        'PORT': 5432,
    }
}
```

Save and close the file.

7. Run the docker-compose up command.

```
$ docker-compose up
Starting composepractice_db_1...
Starting composepractice_web_1...
Attaching to composepractice_db_1, composepractice_web_1
...
db_1  | PostgreSQL init process complete; ready for start up.
...
db_1  | LOG:  database system is ready to accept connections
db_1  | LOG:  autovacuum launcher started
..
web_1 | Django version 1.8.4, using settings 'composeexample.settings'
web_1 | Starting development server at http://0.0.0.0:8000/
web_1 | Quit the server with CONTROL-C.
```

At this point, your Django app should be running at port 8000 on your Docker host. If you are using a Docker Machine VM, you can use the docker-machine ip MACHINE_NAME to get the IP address.

8. Connect to confirm

on mac
`open "http://$(docker-machine ip):8000"`