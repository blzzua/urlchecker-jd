#!/bin/bash

check_url_http_status (){
  URL="$1"
  DEFAULT_STATUSCODE=0  # default.
  STATUSCODE=$(curl -s -I "$URL" | grep -E -o  "HTTP/.{3} [0-9]{3}"  | cut -d\  -f2)
  if [[ "X$STATUSCODE" == "X" ]];
  then
    STATUSCODE="$DEFAULT_STATUSCODE"
  fi
  echo "$STATUSCODE"
}


URL_LIST=urls.txt
if [[ ! -f "$URL_LIST" ]];
then
  echo "File $URL_LIST not found"
  exit 90
fi

cat urls.txt  | while read URL;
do
  STATUSCODE=$(check_url_http_status "$URL")
  ## - при любом "плохом" ответе от сервиса прерывать дальнейшую проверку.
  ## - "живой" - значит код ответа не 5XX или 4XX
  if [[ "$STATUSCODE" -gt 400  ]] || [[  "$STATUSCODE" -lt 100  ]] ;
  then
    echo -- "Выход при плохом коде ответа $STATUSCODE проверки  $URL"
    exit 1
  fi
  true
done


