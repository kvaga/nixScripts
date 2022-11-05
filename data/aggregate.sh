cat localhost_access_log.2022-10-06.txt | grep -v /FeedAggrWebServer | awk '{print $1, 1}' | awk '{arr[$1]+=$2} END {for (i in arr) {print i, arr[i]}}' | sort -k2 -n
