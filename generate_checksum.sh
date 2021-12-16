#!/bin/bash
test -d vendor/cache && rm -rf vendor/cache
sudo bundle install && bundle cache
test -d vendor/cache || exit 1

rm -f checksums.txt

for g in `ls vendor/cache/*.gem`; do
  echo $(sha256sum $g) >> checksums.txt
done

sed 's/vendor\/cache\///' checksums.txt

git commit -am "Update checksums.txt" && exit 0

