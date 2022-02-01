#!/usr/bin/env bash

curl 'http://192.168.1.1/api/model.json?internalapi=1&x=81601' \
  -H 'Cookie: p=password; sessionId=00000001-BNUuYVXENzn5cjdY4Q00CBLCj7MKeTU' \
  --compressed \
  --insecure \
  | sed 's/\r//' \
  | /mingw64/bin/jq '.router.clientList' \
  | awk 'BEGIN {FS="[ \":]+"} /IP.:/ {IP=$3} /MAC/ {MAC=tolower(gensub("-", ":", "G", $3)); printf("%s    %s  (%s)\n", IP, MAC, $3)}'

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

# awk sugrupuoja MAC ir IP va tokiu pavidalu:
#
# 192.168.1.20    08:11:96:15:77:5c  (08-11-96-15-77-5C)
# 192.168.1.60    d4:25:8b:94:d9:78  (D4-25-8B-94-D9-78)
