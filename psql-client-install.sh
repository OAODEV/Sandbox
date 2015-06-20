#!/bin/bash

# Import the PostgreSQL repository signing key
apt-get -qq update && apt-get -y -qq install wget && wget --quiet -O - \
    https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# Add a line for the PostgreSQL repository to the apt cache list
echo "deb http://apt.postgresql.org/pub/repos/apt/ $(lsb_release -cs)-pgdg main" >\
    /etc/apt/sources.list.d/pgdg.list

# Update the package lists, and install Postgres
apt-get update && apt-get install -y postgresql-9.4

# Drop the default postgresql-common cluster;
# we'll be using testing.postgresql to set up ephemeral instances
RUN su - postgres -c "pg_dropcluster --stop 9.4 main"

# link postgres and initdb to /usr/bin
RUN ln -s /usr/lib/postgresql/9.4/bin/pg_ctl /usr/bin/pg_ctl
RUN ln -s /usr/lib/postgresql/9.4/bin/postgres /usr/bin/postgres
RUN ln -s /usr/lib/postgresql/9.4/bin/initdb /usr/bin/initdb

# Install testing.postgresql module
pip install testing.postgresql