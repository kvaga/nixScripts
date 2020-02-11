#/bin/bash

function check_feed43_cache(){
        url=https://feed43.com/3763623437488542_3.xml
        filename=$(basename $url)
        hash_last=null
        hash_new=null
        while [ 1=1 ]; do
                wget -O $filename $url 2>/dev/null
                hash_new=$(sha1sum $filename | awk '{print $1}')
                if [ "$hash_new" == "$hash_last" ]; then
                        echo "[FAIL] hash_new=hash_last $hash_new=$hash_last"
                        curl -i -XPOST 'http://130.61.122.117:8086/write?db=home1' --data-binary 'check_feed43_status value=1'
                else
                        echo "[SUCCESS] hash_new!=hash_last $hash_new=$hash_last"
                        curl -i -XPOST 'http://130.61.122.117:8086/write?db=home1' --data-binary 'check_feed43_status value=-1'
                fi
                hash_last=$hash_new
                sleep 1
        done

}
check_feed43_cache
