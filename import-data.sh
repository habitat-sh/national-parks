#!/bin/bash

mongoimport --drop -d demo -c nationalparks --type json --jsonArray --file ./national-parks.json $*
