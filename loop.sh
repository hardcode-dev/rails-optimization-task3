#!/usr/bin/env bash

set -e

bundle exec rake test

export RAILS_ENV=production
bundle exec ruby bin/rails runner perfolab/my_app/import_stand.rb