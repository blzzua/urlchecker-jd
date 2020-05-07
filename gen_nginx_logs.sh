## генератор данных.

if [[  ! -f log.txt ]]
then
  echo "генерирование тестовых данных"
  datetime_s=$(date --date="2018-03-02" +%s)
  for i in {1..2000} ; do
  ip=192.168.0.$(( RANDOM % 256 ))
      datetime_s=$(( datetime_s + RANDOM % 4 ))
      datetime=$(LC_ALL=C date +"%d/%b/%Y:%T %z"  --date=@$datetime_s)
      body_bytes_sent=$RANDOM
      echo $ip' - - ['$datetime'] "GET /some-url HTTP/1.1" 200 '$body_bytes_sent' 0.009 "https://example.com" "Mozilla/5.0 (X11; Fedora; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/61.0.3163.100 Safari/537.36" [upstream: 127.0.0.1:8000 200] request_id=-'
  done > log.txt
fi


echo "1) простой скрипт-однострочник на bash, который бы выводил ip, с которого пришло больше всего запросов"
set -x
awk '{print $1}' log.txt | sort | uniq -c | sort -nr | head -n1  | awk '{print $2}'
set +x

echo "2) Скрипт на любом знакомом языке программирования или bash, который бы вывел top-10 ip, на которые было отдано больше всего трафика ($body_bytes_sent в логе). Сортировать по убыванию трафика."
set -x
awk '{ip=$1; body_bytes_sent_arr[ip]+=$10;}; END {for (ip in body_bytes_sent_arr){print ip,body_bytes_sent_arr[ip]} } ' log.txt  | sort -rnk2 | head -n10
set +x
