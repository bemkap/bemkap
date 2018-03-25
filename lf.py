import numpy as np
def lab(fn):
    fd=open(fn,'rb')
    fd.seek(8)
    re=bytearray(fd.read())
    fd.close()
    return re

def img(fn):
    fd=open(fn,'rb')
    fd.seek(16)
    re=[i.reshape(784,1) for i in np.split(np.array(fd.read()),60000)]
    fd.close()
    return re

l=lab('labels.idx1-ubyte')
i=img('images.idx3-ubyte')
