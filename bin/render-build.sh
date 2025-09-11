#!/usr/bin/env bash
# exit on error
set -o errexit

gem install bundler -v 2.7.2 --no-document
bundle _2.7.2_ install
bundle exec rake assets:precompile
bundle exec rake assets:clean
# bundle exec rake db:migrate
