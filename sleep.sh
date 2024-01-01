#!/bin/bash

time=$(uptime -s | awk '{print $2}' | awk -F ':' '{print $2%10 * 60 + $3}')

sleep $time
