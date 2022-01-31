curl 'http://192.168.1.1/api/model.json?internalapi=1&x=81601' \
  -H 'Cookie: p=password; sessionId=00000000-dbdNKPzOVdALgI15zV4VFA46QXRwkxh' \
  --compressed \
  --insecure \
  | sed 's/\r//'
