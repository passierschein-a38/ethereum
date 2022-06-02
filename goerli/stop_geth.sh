#!/bin/bash

gth=$(which geth)

echo "geth binary at location: $gth"

process_pid="$(cat geth.pid)"
echo "send SIGINT to $process_pid"
kill -s INT $process_pid
