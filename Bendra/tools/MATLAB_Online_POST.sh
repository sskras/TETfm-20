#!/bin/bash

#FILE_PATH="RESTfull.m"
FILE_PATH="$1"
COMP_SESS_ID="0b71796c-ec81-4b52-93f9-7f01dfef8a97"
COMP_RESC_ADDR="10.97.33.99:8025"

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
  -H 'Referer: https://wrprod01-prod-useast1.mathworks.com/remote/proxy/1.6/iframeProxyRelease.html?routingkey='"$COMP_RESC_ADDR" \
  -H 'Accept-Language: en-US,en;q=0.9,lt;q=0.8,ru;q=0.7' \
  -H 'Cookie: dtCookie=v_4_srv_2_sn_59EFC724CB44757591920B7D7B2265EF_perc_100000_ol_0_mul_1; at_check=true; AMCVS_B1441C8B533095C00A490D4D%40AdobeOrg=1; mwa=%7B%22expiration%22%3A1618075793%2C%22id%22%3A%22i7dqQl%22%7D; mwa_session=%7B%22id%22%3A%22i7dqQl%22%2C%22token%22%3A%22MSw2ZnJpdTAzaWdmcGlpOWt5c2l1N2tqdWcxNGp0YmxlZnNreXRzNWduZHY1MTlvajcsNFRCVm9FWUdKMFY2dDliQWdvTVhYQzJPY3k5c0wvdFFBck41NGl3VGJsazJNZ1YrSU0vbkJTZVVjaTBRV250MnFJVEFBb3VvY2xmN2FvdlVVK1B2QTM5QnpHMklrQ0FYREszSXNJTGppd0FybnlpSGloa0lPZXBsUVRlTk5LaDd4c2FkcUVNMFZUNXRnZk5GR3BQamJmVTlKQ1lrdCtKV0M1cW9FRXJLcmRzRXBYZmFQaHNlb21tQXF5WWlyNHVj%22%7D; mwa_prefs=%7B%22domain%22%3A%22se%22%2C%22lang%22%3A%22%22%2C%22v%22%3A2%7D; AMCV_B1441C8B533095C00A490D4D%40AdobeOrg=-637568504%7CMCIDTS%7C18638%7CMCMID%7C70979489685709337822250080514575503481%7CMCAID%7CNONE%7CMCOPTOUT-1610370925s%7CNONE%7CvVersion%7C5.1.1; mbox=PC#0bd7ca36ba624189b49f6962bda3e5c7.37_0#1673608527|session#bc16c8117a144e10b90d5f456ef5847d#1610365586; MotwParamCookie-JSESSIONID=070f85c8-e31f-4d99-8cc0-2149c04aa1b8; computeToken=070f85c8-e31f-4d99-8cc0-2149c04aa1b8; routingkey=10.97.32.53:8003; s_pers=%20s_nr%3D1610363751268%7C1612955751268%3B%20s_lastvisit%3D1610370834752%7C1704978834752%3B%20c_c35%3Dmy%2520service%2520request%2520-%2520detail%7C1610372844888%3B%20c_c30%3Dunknown%7C1610372844896%3B%20c_c31%3Dunknown%7C1610372844903%3B%20c_c32%3Dsupport%7C1610372844914%3B%20c_vs%3D1%7C1610372844925%3B%20s_dl%3D1%7C1610372844938%3B; s_sess=%20s_ria%3Dflash%2520not%2520detected%257Csilverlight%2520not%2520detected%3B%20c_rand%3D280865%3B%20c_sess%3D280865%253A%253A1610370835%3B%20s_cc%3Dtrue%3B%20s_sq%3Dmathglobaltest%253D%252526pid%25253Dsupport%2525252Fservice_requests%2525252Fcp_case_detail1%252526pidt%25253D1%252526oid%25253Dhttps%2525253A%2525252F%2525252Fservicerequest.mathworks.com%2525252Fmysr%2525252Fcp_case_detail1%2525253Fcc%2525253Dse%25252526id%2525253D5003q00001N1Uhc%25252523%252526ot%25253DA%3B; JSESSIONID=c3GtLTHCjhG0xSbA; ssnc=R71d8U4fjAZnDNDY' \
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
        "computeSessionId":"'"$COMP_SESS_ID"'",
        "serviceUrl":"unset",
        "computeResourceAddress":"'"$COMP_RESC_ADDR"'"
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
