# this command runs our Gunicorn server on port 5000.
gunicorn -b 0.0.0.0:5000 app:app