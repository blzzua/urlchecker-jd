#!/bin/bash

check_url_http_status (){
  URL="$1"
  DEFAULT_STATUSCODE=-1
  CURL=STATUSCODE=$(curl -s -I "$URL" | grep -E -o  "HTTP/.{3} [0-9]{3}"  | cut -d\  -f2):-2
  STATUSCODE=${STATUSCODE:-DEFAULT_STATUSCODE}
}


URL_LIST=urls.txt
if [[ ! -f "$URL_LIST" ]];
then
  echo "File $URL_LIST not found"
  exit 90
fi

cat urls.txt  | while read URL;
do
  STATUSCODE=$(check_url_http_status "$url")
  echo -e "${url}\t${STATUSCODE}"
  true
done

