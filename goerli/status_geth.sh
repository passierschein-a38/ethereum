#!/bin/bash


gth_pid=$(<geth.pid)
echo "test geth pid=$gth_pid via kill -0"

kill -0 $gth_pid

if (( $? == 0 )); then
    echo "geth process up and running"
else
    echo "geth process not running"
fi
