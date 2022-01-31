curl 'http://192.168.1.1/api/model.json?internalapi=1&x=81601' \
  -H 'Cookie: p=password; sessionId=00000001-yTg32I35Tsygf43pjCurMKR8O3P9bbf' \
  --compressed \
  --insecure \
  | sed 's/\r//'
