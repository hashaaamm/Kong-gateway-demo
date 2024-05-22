#!/bin/sh

# Wait for the database to be ready
if [ "$DATABASE" = "postgres" ]
then
    echo "Waiting for postgres..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
      sleep 0.1
    done

    echo "PostgreSQL started"
fi

# Creating database migrations
echo "Creating database migrations..."
python manage.py makemigrations

# Apply database migrations
echo "Applying database migrations..."
python manage.py migrate

python manage.py shell <<EOF
from django.contrib.auth import get_user_model
User = get_user_model()
username = 'shamo'
password = 'mysecretpassword123'
if not User.objects.filter(username=username).exists():
    User.objects.create_superuser(username=username, password=password, email='')
    print("Superuser created.")
else:
    print("Superuser already exists.")
EOF


# Start the Django development server
echo "Starting server..."
python manage.py runserver 0.0.0.0:8000

exec "$@"
