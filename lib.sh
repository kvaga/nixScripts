#/bin/bash

function send_to_influxdb(){
        #echo parameter1:$1 parameter2:$2;
        curl -i -XPOST "http://$INFLUXDB_HOST:$INFLUXDB_PORT/write?db=$INFLUXDB_DB" --data "$1,host=$hostname value=$2"
}

function send_to_influxdb2(){
        # influxdb_url: influxdb_url="https://europe-west1-1.gcp.cloud2.influxdata.com/api/v2/write?org=c4555555555380&bucket=MyBucket&precision=ns"
        curl --request POST "$influxdb_url"   \
--header "Authorization: Token $influxdb_token"   \
--header "Content-Type: text/plain; charset=utf-8"   \
--header "Accept: application/json"   \
--data-binary '
    backupFeedAggrWebServerServerXML value=1
        '
}
