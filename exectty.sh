#!/bin/bash

# Standard `docker exec -t` doesn't create a full tty, and has no $TERM set.
# This creates problems for me sometimes (I like the `clear` command, and
    # psql complains a bit if the client is not a functional terminal).
# I do the command below enough that I made this script.
# Pass it the name or ID of a running container, and Bob's your uncle.
# - tym@adops.com

docker exec -it $1 script -f /dev/null -c "export TERM=xterm && /bin/bash"