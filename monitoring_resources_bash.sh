#! /bin/bash
# v.20190828-3

LOG_FILE=$0.log

function cpu(){
        local res=$(sar 1 3 | grep Average | awk {'print "cpu_user="$3" cpu_system="$5" cpu_idle="$8'})
        echo "$res"
}

function memory(){
        local res=$(free | grep Mem: | awk {'print "mem_used_kb="$3" mem_free_kb="$4'})
        echo "$res"
}

function monitoring(){
        while [ 1=1 ];
                do
                cpu_res=$(cpu)
                mem_res=$(memory)
                date_time="[$(date "+%F %H:%M:%S")]"
                result="$date_time $cpu_res $mem_res"
                # echo $result
                echo $result >> $LOG_FILE
        done;
}


monitoring
