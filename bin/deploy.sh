#!/usr/bin/env bash

set -e

if [[ "false" != "$TRAVIS_PULL_REQUEST" ]]; then
	echo "Not deploying pull requests."
	exit
fi

if [[ "master" != "$TRAVIS_BRANCH" ]]; then
	echo "Not on the 'master' branch."
	exit
fi

rm -fr .git
rm -fr bin
rm -fr data
rm -fr lib
rm -fr node_modules
rm -fr src
rm -fr tags
rm -fr tests
rm -fr .editorconfig
rm -fr .eslintignore
rm -fr .eslintrc.json
rm -fr .gitignore
rm -fr .travis.yml
rm -fr gulpfile.js
rm -fr index.html.ejs
rm -fr karma.conf.js
rm -fr package.json

git init
git config user.name $GIT_USER
git config user.email $GIT_EMAIL

git add css
git add fonts
git add images
git add img
git add thumbnails
git add index.html
git add js
git add json
git add CNAME

touch .nojekyll
git add .nojekyll
git commit --quiet -m "Deploy from travis"
git push --force --quiet "https://${GH_TOKEN}@${GH_REF}" master:gh-pages > /dev/null 2>&1
