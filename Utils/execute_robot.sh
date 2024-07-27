#!/bin/bash

current_date=$(date +"%Y-%m-%d")
robot --loglevel TRACE --outputdir "/opt/robotframework/Results/$current_date" "/opt/robotframework/Tests"