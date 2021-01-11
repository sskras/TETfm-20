#!/bin/bash

#FILE_PATH="RESTfull.m"
FILE_PATH="$1"
CRES_ADDR="10.97.32.53:8003"

curl 'https://wrprod01-prod-useast1.mathworks.com/messageservice/json/secure?routingkey='"$CRES_ADDR" \
  -H 'Connection: keep-alive' \
  -H 'Pragma: no-cache' \
  -H 'Cache-Control: no-cache' \
  -H 'X-Requested-With: XMLHttpRequest' \
  -H 'Content-Type: application/json' \
  -H 'Accept: */*' \
  -H 'Origin: https://wrprod01-prod-useast1.mathworks.com' \
  -H 'Sec-Fetch-Site: same-origin' \
  -H 'Sec-Fetch-Mode: cors' \
  -H 'Sec-Fetch-Dest: empty' \
  --data-binary '
  {
    "uuid":"AC105222",
    "messages":
    {
      "ListVersion":
      [
        {
          "path":"/MATLAB Drive/Published/'"$FILE_PATH"'",
          "uuid":"AE69A3FC"
        }
      ]
    },
    "computeToken":
      {
        "computeSessionId":"070f85c8-e31f-4d99-8cc0-2149c04aa1b8",
        "serviceUrl":"unset",
        "computeResourceAddress":"'$CRES_ADDR'"
      }
  }' \
  --compressed

# On the first sight, both "uuid" fields seems to not matter much as we still get the same output except these two lines:

# --- old_UUIDs.txt       2021-01-11 14:12:10.630226700 +0200
# +++ new_UUIDs.txt       2021-01-11 14:10:34.253427600 +0200
# @@ -1,5 +1,5 @@
#  {
# -  "uuid": "05367410",
# +  "uuid": "CEE5E599",
#    "fault": null,
#    "messages": {
#      "ListVersionResponse": [
# @@ -28,7 +28,7 @@
#            }
#          ],
#          "messageFaults": [],
# -        "uuid": "C8A155BD",
# +        "uuid": "4C9D1233",
#          "apiVersion": "1.6"
#        }
#      ]
