import numpy as np
import struct
import json
def lab(fn):
    fd=open(fn,'rb')
    fd.seek(4)
    sz=struct.unpack(">L",fd.read(4))[0]
    re=np.zeros((sz,10))
    for a,i in enumerate(bytearray(fd.read())): re[a,i]=1
    re=[a.reshape((10,1)) for a in re]
    fd.close()
    return re
def img(fn):
    fd=open(fn,'rb')
    fd.seek(4)
    sz=struct.unpack(">L",fd.read(4))[0]
    fd.seek(16)
    re=[a.reshape((784,1))/255.0 for a in np.split(np.array(bytearray(fd.read())),sz)]
    fd.close()
    return re
def save(fn,ww,bb,sz):
    fd=open(fn,'w')
    data={'ww':[w.tolist() for w in ww],'bb':[b.tolist() for b in bb],'sz':sz}
    json.dump(data,fd)
    fd.close()
def load(fn):
    fd=open(fn,'r')
    data=json.load(fd)
    fd.close()
    return data['ww'],data['bb'],data['sz']
