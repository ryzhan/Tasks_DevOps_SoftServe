#!/bin/bash
set -e
if docker ps -a | awk '{print $NF}' | grep -w carts
then
  exit 0
else
  echo "Container is not created"
  exit 0
fi