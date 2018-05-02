import random
import numpy as np

class CNN(object):
    def __init__(self,ll):
        self.ll=ll
    def ff(self,i):
        for l in self.ll: i=l.ff(i)
        return i
    def bp(self,i,t):
        o=self.ff(i)

class LAYER(object):
    def ff(self,i): pass
    def bp(self,i,h): pass

class CONV(LAYER):
    def __init__(self,n_in,n_fi,st):
        self.n_in=n_in
        self.n_out=((n_in[0]-n_fi+1)/st,(n_in[1]-n_fi+1)/st)
        self.ww=np.random.randn(n_fi,n_fi)
        self.st=st
    def ff(self,i):
        return convolute(i,self.ww,self.st)
    def bp(self,i,h):
        d=convolute(i,h,1)
        self.ww[w+dw for w,db in zip(self.ww,d)]
        return d
    
def convolute(a,b,s):
    sh=((a.shape[0]-b.shape[0]+1)/s,(a.shape[1]-b.shape[1]+1)/s)
    cc=[a[x:x+b.shape[0],y:y+b.shape[1]]
         for x in xrange(0,a.shape[0]-b.shape[0]+1,s)
         for y in xrange(0,a.shape[1]-b.shape[1]+1,s)]
    return np.reshape([np.sum(b*c) for c in cc],sh)

class FULL(LAYER):
    def __init__(self,n_in,n_out,actv,actv1):
        self.w=np.random.randn(n_out,n_in)
        self.b=np.random.randn(n_out,1)
        self.actv=actv
        self.actv1=actv1
    def ff(self,i):
        return self.actv(np.dot(self.w,i)+self.b)
    def bp(self,i,h):
        d=np.dot(self.w.transpose,h)*self.actv1(i)
        self.b+=d
        self.w+=np.dot(d,self.actv(i).transpose)
        return d

class POOL(LAYER):
    def __init__(self,n_fi,st):
        self.n_fi=n_fi
        self.st=st
    def ff(self,i):
        sh=((i.shape[0]-self.n_fi)/self.st+1,(i.shape[1]-self.n_fi)/self.st+1)
        self.dm=np.zeros_like(i)
        cc=[np.max(i[x:x+self.n_fi,y:y+self.n_fi])
            for x in xrange(0,i.shape[0],self.st)
            for y in xrange(0,i.shape[1],self.st)]
        return np.reshape(cc,sh)
    def bp(self,i,h):
        return h

class SOFT(LAYER):
    def ff(self,i):
        return i/np.sum(i)
    def bp(self,i,h):
        return h

class RELU(LAYER):
    def ff(self,i):
        relu=np.vectorize(lambda x:max(0.,x))
        return relu(i)
    def bp(self,i,h):
        return h

class FLAT(LAYER):
    def ff(self,i):
        return np.reshape(i,(i.shape[0]*i.shape[1],1))
    def bp(self,i,h):
        return h
