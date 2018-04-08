import random
import numpy as np
class CONV(object):
    def __init__(self,n_in,n_fi,st):
        self.n_in=n_in
        self.n_out=((n_in[0]-n_fi+1)/st,(n_in[1]-n_fi+1)/st)
        self.ww=np.random.randn(n_fi,n_fi)
        self.st=st
    def ff(self,i):
        return convolute(i,self.ww,self.st)
    def bp(self,i,h):
        self.ww=[w+dw for w,dw in zip(self.ww,convolute(i,h,s))]

def convolute(a,b,s):
    sh=((a.shape[0]-b.shape[0]+1)/s,(a.shape[1]-b.shape[1]+1)/s)
    cc=[a[x:x+b.shape[0],y:y+b.shape[1]]
         for x in xrange(0,a.shape[0]-b.shape[0]+1,s)
         for y in xrange(0,a.shape[1]-b.shape[1]+1,s)]
    return np.reshape([np.sum(b*c) for c in cc],sh)

class FULL(object):
    def __init__(self,n_in,n_out,norm,norm1):
        self.w=np.random.randn(n_out,n_in)
        self.b=np.random.randn(n_out,1)
        self.norm=norm
        self.norm1=norm1
    def ff(self,i):
        return self.norm(np.dot(self.w,i)+self.b)
    def bp(self,z,d):
        d=np.dot(self.w.transpose(),d)*self.norm1(z)
        self.b+=d
        self.w+=np.dot(d,self.norm(z).transpose)
        

# class NN(object):
#     def __init__(self,sz):
#         self.sz=sz
#         self.ww=[np.random.randn(sz[i+1],sz[i]) for i in xrange(len(sz)-1)]
#         self.bb=[np.random.randn(sz[i+1],1) for i in xrange(len(sz)-1)]
#     def ff(self,i):
#         self.zz=[]
#         for w,b in zip(self.ww,self.bb):
#             i=np.dot(w,i)+b
#             self.zz.append(i)
#             i=sigmoid(i)
#         return i
#     def dl(self,i,t):
#         dd=[(self.ff(i)-t)]
#         for i in xrange(len(self.ww)-1):
#             dd.insert(0,np.dot(self.ww[-1-i].transpose(),dd[0])*sigmoid1(self.zz[-2-i]))
#         return dd
#     def dbw(self,it):
#         dbb,dww=[np.zeros(b.shape) for b in self.bb],[np.zeros(w.shape) for w in self.ww]
#         for i,t in it:
#             dd=self.dl(i,t)
#             dbb=[b+db for b,db in zip(dbb,dd)]
#             aa=[i]+[sigmoid(z) for z in self.zz[:-1]]
#             dww=[w+dw for w,dw in zip(dww,[np.dot(d,a.transpose()) for d,a in zip(dd,aa)])]
#         return dbb,dww
#     def sgd(self,it,sz,eta,eps,lam):
#         for i in xrange(eps):
#             random.shuffle(it)
#             for j in xrange(0,len(it),sz):
#                 dbb,dww=self.dbw(it[j:j+sz])
#                 self.bb=[b-eta/sz*db for b,db in zip(self.bb,dbb)]
#                 self.ww=[(1-eta*lam/len(it))*w-eta/sz*dw for w,dw in zip(self.ww,dww)]
#     def test(self,it):
#         return np.sum([float(np.argmax(t)==np.argmax(self.ff(i))) for i,t in it])/len(it)

# def sigmoid(x): return 1.0/(1.0+np.exp(-x))
# def sigmoid1(x): return sigmoid(x)*(1-sigmoid(x))
