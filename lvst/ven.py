import BeautifulSoup
import urllib2
import sys
import json

class db:
    def __init__(self):
        with open("db.json","r") as fd:
            self.dic=json.load(fd)
    def record(self,r1,r2):
        url="http://venganzasdelpasado.com.ar/posts/page/{0}"
        for n in xrange(r1,r2+1):
            p=urllib2.urlopen(url.format(n)).read()
            t=BeautifulSoup.BeautifulSoup(p,"html.parser")
            for l in t.findAll("source"):
                u=l.get("src")
                self.dic.setdefault(u[-14:],{"name":u,"downloaded":False})
    def download(self,n):
        for k in dic:
            self.download_one(k)
            n=n-1
            if n<=0: break
    def download_one(self,k):
        if not self.dic[k]["downloaded"]:
            mp3=urllib2.urlopen(self.dic[k]["name"])
            with open(k,"wb") as fd: fd.write(mp3.read())
            self.dic[k]["downloaded"]=True
    def downloaded(self):
        return([k for k in self.dic if self.dic[k]["downloaded"]])
    def left(self):
        return([k for k in self.dic if not self.dic[k]["downloaded"]])
    def __del__(self):
        with open("db.json","w") as fd:
            fd.write(json.dumps(self.dic))
