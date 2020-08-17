# pdf-to-ipp

Expose a rest API and web interface to receive pdf files and forward them to an IPP printer on the network.

## Why?

I needed an easy way for me as a human from all sorts of devices print pdf files, before I created this I used google CloudPrint which was great but they are [shutting down the service](https://support.google.com/chrome/a/answer/9633006?hl=en).
Also, it wasn't flexible to be used with random scripts without jumping through complicated authentication hoops so I've created this *simple* http app that can run anywhere and point to any ipp printer it can reach.


## how to use?
Run the container and place your printer's ip in the env var `IPP_IP` like in the bellow example docker run command.

```
docker run -d -p 5000:5000 -e "IPP_IP=192.168.1.66" aapjeisbaas/pdf-to-ipp
```

Now you can reach the web interface of the service at: http://127.0.0.1:5000/

This is pretty useful by itself but if you're anything like me you want to automate your printing.
The application expects A4 pdf files to be uploaded to: `http://127.0.0.1:5000/uploader` in a python function this will look like the one below.

```python

import requests

def send_to_printer(pdf):
    files = {'file': open(pdf, 'rb')}
    requests.post('http://127.0.0.1:5000/uploader', files=files)

send_to_printer('/home/user/pdf/print-this.pdf')

```