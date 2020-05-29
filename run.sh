#!/bin/bash
# Sometimes the python server fails to quit
# This checks if the server is running on port 8000
# An kills it befreore launching 'publish run'

PID=$(lsof -nP -i4TCP:8000 | grep LISTEN | cut -d' ' -f2)

if [ -n "$PID" ]
then
  #Server running on pid $PID
  sudo kill -9 $PID
fi
publish run
