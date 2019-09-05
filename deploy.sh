#!/usr/bin/env bash
./sdeploy.sh
git checkout gh-pages
rsync -avzh --delete --exclude '.git' ./ docker@app.afsys.com.br:/home/docker/ruby/afsys_production/apidoc
git checkout master
