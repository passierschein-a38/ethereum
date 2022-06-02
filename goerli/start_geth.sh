#!/bin/bash

gth=$(which geth)

echo "geth binary at location: $gth"

data_dir="$(pwd)/data"
ipc_path="$data_dir/goerli/goerli.ipc"
logfile="$(pwd)/logs/goerli.log"
#cfg="$(pwd)/config/goerli.toml"


geth --goerli --datadir $data_dir --syncmode "snap" --lightkdf --cache 1024  --http --ws --pprof  --metrics --maxpeers 5 --ipcpath $ipc_path > $logfile 2>&1 &

process_pid=$!
echo "pid: $process_pid, writing logs to $logfile"
echo $process_pid > geth.pid
