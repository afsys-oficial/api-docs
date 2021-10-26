#!/usr/bin/env bash
mv build/stylesheets/print build/stylesheets/print.css
mv build/stylesheets/screen build/stylesheets/screen.css

./sdeploy.sh -v
git checkout gh-pages
rsync -avzh --delete --exclude '.git' ./ docker@app.afsys.com.br:/home/docker/ruby/afsys_production/apidoc
git checkout master
