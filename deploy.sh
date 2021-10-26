#!/usr/bin/env bash
./sdeploy.sh -v

mv build/stylesheets/print build/stylesheets/print.css
mv build/stylesheets/screen build/stylesheets/screen.css

git checkout gh-pages
rsync -avzh --delete --exclude '.git' ./ docker@app.afsys.com.br:/home/docker/ruby/afsys_production/apidoc
git checkout master
