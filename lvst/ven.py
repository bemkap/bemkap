from bs4 import BeautifulSoup
from urllib2 import urlopen
import sys
import json
from math import ceil

class db:
    def __init__(self,listener):
        self.listener=listener
        self.CHUNK=4096*16
        with open("db.json","r") as fd:
            self.dic=json.load(fd)
    def record(self,r1,r2):
        url="http://venganzasdelpasado.com.ar/posts/page/%d"
        for n in xrange(r1,r2+1):
            p=urlopen(url%n).read()
            t=BeautifulSoup.BeautifulSoup(p,"html.parser")
            for l in t.findAll("source"):
                u=l.get("src")
                self.dic.setdefault(u[-14:],{"name":u,"downloaded":False})
    def download(self,k,n):
        if not self.dic[k]["downloaded"]:
            mp3=urlopen(self.dic[k]["name"])
            size=float(mp3.info()["Content-Length"])
            with open(k,"wb") as fd:
                for i in xrange(int(ceil(size/self.CHUNK))):
                    d=mp3.read(self.CHUNK)
                    fd.write(d)
                    s="%.2fMB/%.2fMB"%(float(i*self.CHUNK)/1e6,size/1e6)
                    self.listener.act(s,n)
            self.listener.finish()
        else:
            self.listener.act("already downloaded")
    def set(self,k):
        self.dic[k]["downloaded"]=True
    def downloaded(self):
        return([k for k in self.dic if self.dic[k]["downloaded"]])
    def left(self):
        return([k for k in self.dic if not self.dic[k]["downloaded"]])
    def close(self):
        with open("db.json","w") as fd:
            fd.write(json.dumps(self.dic))
