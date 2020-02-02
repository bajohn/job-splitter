#!/bin/bash
rm -r ./out/*
SITE_PACKAGES=$(pipenv --venv)/lib/python3.7/site-packages
PACKAGE_ZIP='lib.zip'
DIR=`pwd`
OUTDIR=$DIR/out

cd $SITE_PACKAGES
zip -r9 $OUTDIR/$PACKAGE_ZIP *
cd $DIR/lambdas 
for file_inner in ./**
do
    len=${#file_inner}

    shortfile=${file_inner:2:len-5} # change this to "not have the .py" exclude last 3 characters

    for file_inner in ./**
    do
        zip -r9g $OUTDIR/$shortfile.zip $file_inner
    done

    aws s3 cp  $OUTDIR/$shortfile.zip s3://tf-changedname/$shortfile.zip
done


aws s3 cp $OUTDIR/$PACKAGE_ZIP s3://tf-changedname/$PACKAGE_ZIP