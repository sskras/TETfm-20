curl 'http://192.168.1.1/api/model.json?internalapi=1&x=81601' \
  -H 'Cookie: p=password; sessionId=00000001-yTg32I35Tsygf43pjCurMKR8O3P9bbf' \
  --compressed \
  --insecure \
  | sed 's/\r//' \
  | /mingw64/bin/jq '.router.clientList'

# jq iškerpta tokį gabalėlį:
#
# [
#   {
#     "IP": "192.168.1.20",
#     "MAC": "08-11-96-15-77-5C",
#     "name": "",
#     "onUSB": false,
#     "source": "PrimaryAP"
#   },
#   {
#     "IP": "192.168.1.60",
#     "MAC": "D4-25-8B-94-D9-78",
#     "name": "DESKTOP-O7JE7JE",
#     "onUSB": false,
#     "source": "PrimaryAP"
#   },
#   {}
# ]
