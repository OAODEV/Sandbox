#!/bin/bash

# Add add a line for the Postgres repository
echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" >> /etc/apt/sources.list.d/pgdg.list
# Import the repository signing key
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | \
  sudo apt-key add -

# Update the package lists, and install psql client
sudo apt-get update && apt-get install postgresql-client-9.4