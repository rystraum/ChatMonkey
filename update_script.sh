#!/bin/bash

# This Source Code Form is subject to the terms of the Mozilla Public
# License, v. 2.0. If a copy of the MPL was not distributed with this file,
# You can obtain one at http://mozilla.org/MPL/2.0/.
# (c) Rystraum Gamonez

if [ -z $1 ]; then
  echo "You didn't provide a version number, current_version.rb says"
  cat config/initializers/current_version.rb
  exit 1
fi

TAG=$1
RAILS_ENV=production
sed -i "s/'\(.*\)'/'$TAG'/" config/initializers/current_version.rb &&
git add . &&
git commit -m "version bump to $TAG" &&
git checkout master &&
git merge --no-ff development &&
rake assets:clean &&
rake assets:precompile &&
git add . &&
git commit -m "version bump to $TAG" &&
git tag $TAG &&
git push &&
git push --tags &&
git checkout production &&
git merge --no-commit master &&
git push &&
git checkout development

echo "update completed"

