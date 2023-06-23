#!/bin/sh

git fetch --all
git reset --hard origin/main

cd community/
git fetch --all
git reset --hard origin/develop
