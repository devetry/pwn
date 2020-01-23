pip3 install -r requirements.txt
gunicorn -w 4 src.app:app
