#!/bin/bash

set -m

echo "Bundling gems"
bundle install

echo "Drops the database"
bundle exec rake db:drop   

wait $!

echo "Create database"
bundle exec rake db:create 

wait $!

echo "Run migrations"
bundle exec rake db:migrate

wait $!

echo "Seed database"
bundle exec rake db:seed

wait $!

echo "Starting app server ..."
bundle exec rackup --host 0.0.0.0 -p 4567 

wait $!

cd testing

bundle exec rake parallel:spec

wait -n
exec "$@"
