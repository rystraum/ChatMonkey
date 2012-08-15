#!/bin/bash

git checkout production && git merge --no-ff master && rake assets:clean && RAILS_ENV=production rake assets:precompile && git add . && git commit -am "assets" && wn push && git checkout development 
