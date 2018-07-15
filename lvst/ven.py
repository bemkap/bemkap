import BeautifulSoup
import urllib2
import sys
import json

def record(r1,r2):
    url='http://venganzasdelpasado.com.ar/posts/page/{0}'
    with open("db.json","r") as fd: dic=json.load(fd)
    for n in xrange(r1,r2+1):
        print('{0}  '.format(n)),
        sys.stdout.flush()
        p=urllib2.urlopen(url.format(n)).read()
        t=BeautifulSoup.BeautifulSoup(p,'html.parser')
        for l in t.findAll('source'):
            u=l.get('src')
            dic.setdefault(u[-14:],{'name':u,'downloaded':False})
    with open("db.json","w") as fd: fd.write(json.dumps(dic))

def download(n):
    with open("db.json","r") as fd: dic=json.load(fd)
    for k in dic:
        if not dic[k]['downloaded']:
            print('{0}...'.format(k)),
            sys.stdout.flush()
            mp3=urllib2.urlopen(dic[k]['name'])
            with open(k,"wb") as fd: fd.write(mp3.read())
            print('OK')
            sys.stdout.flush()
            dic[k]['downloaded']=True
            n=n-1
            if n<=0: break
    with open("db.json","w") as fd: fd.write(json.dumps(dic))

def left():
    with open("db.json","r") as fd: dic=json.load(fd)
    print('{0} left'.format(len([k for k in dic if not dic[k]['downloaded']])))
    
if sys.argv[1]=='r': record(int(sys.argv[2]),int(sys.argv[3]))
elif sys.argv[1]=='d': download(int(sys.argv[2]))
elif sys.argv[1]=='l': left()
elif sys.argv[1]=='h': print(sys.argv[0]+'(r <from> <to>/d <n>/l)')
