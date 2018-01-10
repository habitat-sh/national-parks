#!/bin/bash

docker run -it -e HAB_MONGODB="$(cat mongo.toml)" -p 27017:27017 core/mongodb
