#!/bin/bash

# this is b/c pipenv stores the virtual env in a different
# directory so we need to get the path to it
SITE_PACKAGES=$(pipenv --venv)/lib/python3.7/site-packages
echo "Library Location: $SITE_PACKAGES"
DIR=`pwd`

# Make sure pipenv is good to go
# echo "Do fresh install to make sure everything is there"
# pipenv install

zip -r9 package.zip ./lambdas

cd $SITE_PACKAGES
zip -rg9 $DIR/package.zip *


aws s3 cp $DIR/package.zip s3://tf-changedname/package.zip