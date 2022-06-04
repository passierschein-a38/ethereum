#!/bin/bash

exec > >(exec logger -p user.info) 2> >(logger -p user.warn)

gth=$(which geth)

echo "geth binary at location: $gth"

data_dir="$(pwd)/data"
ipc_path="$data_dir/goerli/goerli.ipc"
logfile="$(pwd)/logs/goerli.log"
#cfg="$(pwd)/config/goerli.toml"

#metrics standalone uri http://<metrics.addr>:<metrics.port>:/debug/metrics

geth --goerli --datadir $data_dir --syncmode "snap" --lightkdf --cache 2048  --http --http.addr 0.0.0.0 --ws --pprof  --metrics --metrics.expensive --metrics.addr 0.0.0.0 --metrics.port 6066   --maxpeers 5 --ipcpath $ipc_path & 

process_pid=$!
echo "pid: $process_pid, writing logs to $logfile"
echo $process_pid > geth.pid
