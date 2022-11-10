#!/usr/bin/env python
import hashlib
import hmac
from datetime import datetime
import requests


# secret = b'P/EbcdS1tuExUVPz7jI/2ZtayEZb2oDvWd5IYfGQ0jc='
secret = b'changeme'
method = 'POST'
filename = 'image.jpg'
adr = 'http://localhost:8080'
# current date and time
timestamp = int(datetime.timestamp(datetime.now()))
print(timestamp)

print(adr)

data = f"{method}|{adr}|{str(timestamp)}".encode()
print(data)

# hmac.new([key], [data], [algorithm])
hmac_now = hmac.new(secret, data, hashlib.sha256).hexdigest()
print(timestamp, hmac_now)

with open(filename, 'rb') as f:
    image = f.read()

res = requests.post(adr,
                    data=image,
                    headers={'Content-Type': 'image/jpeg', 'X-Authenticate-Timestamp': f'{timestamp}', 'X-Authenticate-Signature': f'{hmac_now}'})
print(res)