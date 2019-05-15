import grequests
import json
import base64
# import time
import datetime


# to fetch the final shadowsocks webpage URL

rs = (grequests.get( "https://umc-common.upaidui.com/ss" ) for _ in xrange(10))

results =  grequests.map(rs)

urls = []
for r in results:
    if r.status_code == 200:
        try:
            d = json.loads( r.text )
            if d["errcode"] == -1 and "url" in d["data"] :
                b64 = d["data"]["url"]
                url =  base64.b64decode( b64 )     
                urls.append(url)
        except:
            pass

urls.sort()

for url in urls:
    # print url
    pass

url =  urls[-1]
idx = url.find( "ts=" )
ts =  int(url[idx+3:])

date = datetime.datetime.fromtimestamp( ts ).strftime('%Y-%m-%dT%H:%M:%SZ')
print url , date 

print "done"
