#!/usr/bin/env bash
# exit on error
set -o errexit

# Ruby のセットアップ（rbenv 経由）
if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi

echo "Using Ruby version: $(ruby -v)"

# Bundler をインストール（必要なら）
gem install bundler -v "~>2.5" --no-document

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
#bundle exec rake db:migrate
