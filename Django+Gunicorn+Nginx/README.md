# Django + Gunicorn + Nginx

* Python 3.8.10
* Django 4.1.2  
* Gunicorn 20.1.0  
* Nginx 1.18.0

### Install pip \& pyvenv

```bash
sudo apt install python-is-python3 python3-pip python3-venv
echo "export PATH=\$PATH:\$HOME/.local/bin" >> ~/.bashrc
source ~/.bashrc
pip install pyvenv
```

### Create Directory for Project

```bash
cd ~
mkdir project
cd poject
mkdir proj sock
```

### Create Virtual Environment

```bash
pyvenv create proj
pyvenv shell proj   # Copy to Clipboard
^v                  # Paste
```

### Install Django \& Gunicorn via Virtual Environment (proj)

```bash
pip install Django gunicorn
cd proj
django-admin startproject conf .
```

### Django Configuration

```bash
vi conf/settings.py
```

```py
import os                                       # line 14 (insert)
ALLOWED_HOSTS = ['*']                           # line 29 (update)
STATIC_ROOT = os.path.join(BASE_DIR, 'static/') # line last (insert)
```

```bash
./manage.py makemigrations
./manage.py migrate
./manage.py createsuperuser     # for Admin Page
./manage.py collectstatic
./manage.py runserver           # test
gunicorn conf.wsgi:application  # test
```

If you work well, escape the virtual environment
```bash
deactivate
```

### Create Gunicorn Service

```bash
sudo vi /etc/systemd/system/gunicorn.service
```
```service
[Unit]
Description=gunicorn daemon
After=network.target

[Service]
User=yun
Group=www-data
WorkingDirectory=/home/[user]/project/proj
ExecStart=/home/[user]/.local/share/pyvenv/proj/bin/gunicorn \
          --workers 2 \
          --bind unix:/home/[user]/project/sock/gunicorn.sock \
          conf.wsgi:application

[Install]
WantedBy=multi-user.target
```

```bash
sudo systemctl daemon-reload
sudo systemctl enable gunicorn
sudo service gunicorn start
sudo service gunicorn status  # check work
```

### Nginx Configuration

```bash
sudo apt install nginx
sudo vi /etc/nginx/site-available/project.conf
```

```nginx
server {
    listen 80;
    server_name 192.168.0.50;   # your ip or domain address
    
    location = /favicon.ico { access_log off; log_not_found off; }
    
    location /static/ {
        root /home/[user]/project/proj;
    }
    
    location / {
        include proxy_params;
        proxy_pass http://unix:/home/[user]/project/sock/gunicorn.sock;
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/project.conf /etc/nginx/sites-enabled/
sudo nginx -t   # test
sudo service nginx restart
```
