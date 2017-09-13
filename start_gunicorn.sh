#!/bin/bash

NAME=transp                                             # Name of application
USER=nginx                                              # User who can run this script
GROUP=webdata                                           # Group who can run his script
DJANGODIR=/home/ritesh/transport3/transp                # Dajango project home directory
SOCKFILE=/home/ritesh/transport3/transp/gunicorn.sock   # Gunicorn unix socket file || we will communicate using this file
DJANGO_SETTINGS_MODULE=transp.settings                  # Setting file django should use
DJANGO_WSGI_MODULE=transp.wsgi                          # Module name of wsgi which will be executed by this script
NUM_WORKERS=2

echo "Starting application $NAME as `whoami`"

# Move to django project directory
cd $DJANGODIR

# command to activate environment
source ../envproj/bin/activate

# set django settings and python path environment variable
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Command to Start your Django Gunicorn using socket used when we will be using nginx server
# exec ../envproj/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
# --name $NAME --workers $NUM_WORKERS --bind=unix:$SOCKFILE # --user $USER

# Command to Start your Django Gunicorn as runserver of django binding it to localhost and port 8000
exec ../envproj/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
 --name $NAME --workers $NUM_WORKERS --bind=127.0.0.1:8000 --log-level debug # --user $USER