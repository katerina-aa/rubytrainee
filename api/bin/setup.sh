#!/bin/bash

set -m

echo "Bundling gems"
bundle install
echo $?

echo "Drops the database"
bundle exec rake db:drop   

wait $!
echo $?
echo "Create database"
bundle exec rake db:create

wait $!
echo $?
echo "Run migrations"
bundle exec rake db:migrate

wait $!
echo $?
echo "Seed database"
bundle exec rake db:seed

wait $!
echo $?
echo "Starting app server ..."
bundle exec rackup --host 0.0.0.0 -p 4567 &
echo $?
cd testing
echo $?
bundle exec rake parallel:spec

wait -n
exec "$@"
