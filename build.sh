#!/bin/sh
echo "Starting build"
docker build . -t glob_test:latest -f x86_64.dockerfile
echo "Finished build"
