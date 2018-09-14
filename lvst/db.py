try:
    import BeautifulSoup
except ImportError:
    from bs4 import BeautifulSoup
from urllib2 import urlopen
import json
from math import ceil

class db:
    def __init__(self,listener):
        self.listener=listener
        self.CHUNK=4096*16
        try:
            with open("db1.json","r") as fd: self.dic=json.load(fd)
        except IOError:
            self.dic={}
    def record(self,r1,r2):
        url="http://venganzasdelpasado.com.ar/posts/page/%d"
        for n in xrange(r1,r2+1):
            p=urlopen(url%n).read()
            t=BeautifulSoup(p,"html.parser")
            for e in t.findAll("article",{"class":"post"}):
                s=e.find("source").get("src")
                c=e.find("div",{"class":"content"}).get_text()
                self.dic.setdefault(s.split("/")[-1],{"s":s,"c":c,"dl":False})
    def download(self,k,n):
        if not self.dic[k]["dl"]:
            mp3=urlopen(self.dic[k]["s"])
            size=float(mp3.info()["Content-Length"])
            with open(k,"wb") as fd:
                for i in xrange(int(ceil(size/self.CHUNK))):
                    fd.write(mp3.read(self.CHUNK))
                    s="%.2fMB/%.2fMB"%(float(i*self.CHUNK)/1e6,size/1e6)
                    self.listener.act(s,n)
            self.listener.finish()
        else:
            self.listener.act("already downloaded",n)
    def content(self,k):
        return self.dic[k]["c"]
    def set(self,k):
        self.dic[k]["dl"]=True
    def downloaded(self):
        return([k for k in self.dic if self.dic[k]["dl"]])
    def left(self):
        return([k for k in self.dic if not self.dic[k]["dl"]])
    def close(self):
        with open("db1.json","w") as fd: fd.write(json.dumps(self.dic))
