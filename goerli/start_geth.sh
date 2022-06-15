#!/bin/bash

#exec > >(exec logger -p user.info) 2> >(logger -p user.warn)

gth=$(which geth)

data_dir="$(pwd)/data"
ipc_path="$data_dir/goerli/goerli.ipc"
logfile=~/Library/Logs/goerli.log
#cfg="$(pwd)/config/goerli.toml"

echo $logfile
touch $logfile

#metrics standalone uri http://<metrics.addr>:<metrics.port>:/debug/metrics

echo $gth
echo $logfile
echo $ipc_path
echo $data_dir

$gth --goerli --datadir $data_dir --syncmode "snap" --lightkdf --cache 2048  --http --http.addr 0.0.0.0 --ws --pprof  --metrics --metrics.expensive --metrics.addr 0.0.0.0 --metrics.port 6066   --maxpeers 5 --ipcpath $ipc_path > $logfile 2>&1  & 

echo $!>geth.pid

gth_pid=$(<geth.pid)
echo "pid=$gth_pid"
disown -h $gth_pid 


( tail -f $logfile | logger -t blockchain )  &
log_pid=$!
echo "logger pid=$log_pid"
disown -h $log_pid

function check_process(){
 
    local p=$1
    echo "check process with pid=$p"
 
    while (kill -0 $p && test $? -eq 0);
    do
        sleep 1
    done
}

( check_process $gth_pid && echo "gth process exited $gth_pid, now kill logger log_pid=$log_pid"; pkill -P  $log_pid) &
echo "background check pid=$!"
disown -h $!

