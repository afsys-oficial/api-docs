#!/usr/bin/env bash
./sdeploy.sh -v
git checkout gh-pages

mv stylesheets/print stylesheets/print.css
mv stylesheets/screen stylesheets/screen.css

rsync -avzh --delete --exclude '.git' ./ docker@app.afsys.com.br:/home/docker/ruby/afsys_production/apidoc
git checkout master

rm -rf stylesheets
