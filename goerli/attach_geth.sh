#!/bin/bash

gth=$(which geth)

echo "geth binary at location: $gth"
data_dir="$(pwd)/data"
ipc_path="$data_dir/goerli/goerli.ipc"

geth --goerli  attach "$ipc_path"  
