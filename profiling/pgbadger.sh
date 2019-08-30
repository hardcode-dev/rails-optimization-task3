#!/bin/bash

docker run -it --rm \
    -v $(pwd):/prof \
    pgbadger:1.0 \
    pgbadger -o /prof/out.html /prof/postgresql-2019-08-28_082731.log
