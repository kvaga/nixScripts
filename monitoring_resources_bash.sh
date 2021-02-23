#! /bin/bash
# v.20190828-3

# Go to the script's path beacuse we need env.sh
cd "${BASH_SOURCE%/*}/"
echo Working directory=$(pwd)
# Configuration
MODE=1
source env.sh

###############
MODE_LOG=1
MODE_GRAFANA=2
MODE_ALL=3
hostname=$(hostname)

LOG_FILE=$0.log
# Create influxdb database: curl -i -XPOST http://localhost:8086/query --data-urlencode "q=CREATE DATABASE mydb"
# Write data to influxdb: curl -i -XPOST 'http://localhost:8086/write?db' --data 'cpu_load_short,host=server01 value=0.64'

function cpu(){
        local res=$(sar 1 3 | grep Average | awk {'print "cpu_user="$3" cpu_system="$5" cpu_idle="$8'})
        echo "$res"
}

function memory(){
        local res=$(free | grep Mem: | awk {'print "mem_used_kb="$3" mem_free_kb="$4'})
        echo "$res"
}

function send_to_influxdb(){
	#echo $1 $2;
	curl -i -XPOST "http://$INFLUXDB_HOST:$INFLUXDB_PORT/write?db=$INFLUXDB_DB" --data "$1,host=$hostname value=$2"
}

function monitoring(){
        #while [ 1=1 ];
	for ((i=0;i<1;i++));
                do
                cpu_res=$(cpu)
                mem_res=$(memory)
                date_time="[$(date "+%F %H:%M:%S")]"
                result="$date_time $cpu_res $mem_res"
                # echo $result
		if [ $MODE=$MODE_LOG ] || [ $MODE=$MODE_ALL ];
		then
                	echo $result >> $LOG_FILE;
		fi
		if [ $MODE=$MODE_GRAFANA ] || [ $MODE=$MODE_ALL ];
		then
			#if [[ "[2021-02-23 15:19:38] cpu_user=33.4 cpu_system=43.4 cpu_idle=44.6 mem_used_kb=711364 mem_free_kb=103736" =~ cpu_user=([0-9]+\.[0-9]+)' 'cpu_system=([0-9]+\.*[0-9]*)' 'cpu_idle=([0-9]+\.*[0-9]*)' 'mem_used_kb=([0-9]+)' 'mem_free_kb=([0-9]+) ]]; then echo "${BASH_REMATCH[1]} ${BASH_REMATCH[2]} ${BASH_REMATCH[3]} ${BASH_REMATCH[4]} ${BASH_REMATCH[5]}"; fi
			if [[ $result =~ cpu_user=([0-9]+\.[0-9]+)' 'cpu_system=([0-9]+\.*[0-9]*)' 'cpu_idle=([0-9]+\.*[0-9]*)' 'mem_used_kb=([0-9]+)' 'mem_free_kb=([0-9]+) ]]; then 
				send_to_influxdb cpu_user ${BASH_REMATCH[1]};
				send_to_influxdb cpu_system ${BASH_REMATCH[2]}; 
				send_to_influxdb cpu_idle ${BASH_REMATCH[3]}; 
				send_to_influxdb mem_used_kb ${BASH_REMATCH[4]}; 
				send_to_influxdb mem_free_kb ${BASH_REMATCH[5]}; 
			fi
			#send_to_grafana $result;
		fi
        done;
}


monitoring
