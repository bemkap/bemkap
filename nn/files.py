import numpy as np
import struct
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
