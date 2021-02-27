#/bin/bash

function send_to_influxdb(){
        #echo parameter1:$1 parameter2:$2;
        curl -i -XPOST "http://$INFLUXDB_HOST:$INFLUXDB_PORT/write?db=$INFLUXDB_DB" --data "$1,host=$hostname value=$2"
}

