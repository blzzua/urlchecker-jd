# urlchecker
url checker
test job

The script work list of URLs (urls.txt) and verify that they are all "alive".
- "alive" - means the response code is not 5XX or 4XX
- the checker designed as a bash function, which called from script
- the function take parameter as an input parameter  $1 as URL and check. return http status or 0 on other errors.
- for any "bad" response from the service, interrupt further checks.
