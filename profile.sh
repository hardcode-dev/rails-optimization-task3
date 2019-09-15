#!/bin/bash

docker run -it \
    -v $(pwd):/home/massif/test \
    -e DATA_FILE=small.txt \
    spajic/docker-valgrind-massif \
    bash
#    valgrind --tool=massif bundle exec rake reload_json[fixtures/small.json]