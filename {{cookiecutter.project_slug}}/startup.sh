#!/bin/bash

echo "Starting postgresql..."
sed -i.bak -e s/peer/trust/g -e s/md5/trust/g /etc/postgresql/9.5/main/pg_hba.conf
service postgresql restart

echo "Setting up postgres users..."
su postgres -c "psql -c 'alter role postgres password null;'"
su postgres -c "psql -c 'CREATE ROLE root LOGIN password null;'"
su postgres -c "psql -c 'CREATE ROLE {{ cookiecutter.username }} LOGIN password null;'"
su postgres -c "psql -c 'ALTER USER root CREATEDB;'"
su postgres -c "psql -c 'ALTER USER {{ cookiecutter.username }} CREATEDB;'"

echo "Starting Redis (for catfish)..."
redis-server &
sleep 3

echo "Starting SSHD..."
/usr/sbin/sshd -D
