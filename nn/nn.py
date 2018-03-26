import numpy as np
import files as fi
class NN:
    def __init__(self,sz):
        self.ww=[np.random.rand(sz[i+1],sz[i]) for i in xrange(len(sz)-1)]
        self.bb=[np.random.rand(sz[i+1],1) for i in xrange(len(sz)-1)]
    def ff(self,i):
        self.zz=[]
        for w,b in zip(self.ww,self.bb):
            i=np.dot(w,i)+b
            self.zz.append(i)
            i=sigmoid(i)
        return i
    def dl(self,i,t):
        o=self.ff(i)
        self.dd=[(o-t)*sigmoid1(self.zz[-1])]
        for i in xrange(len(self.ww)-1):
            self.dd.insert(0,np.dot(np.transpose(self.ww[-1-i]),self.dd[0])*sigmoid1(self.zz[-i-2]))
        return self.dd
    def dbw(self,ii,tt):
        db=[]
        dw=[]
        for i,t in zip(ii,tt):
            db.append(self.dl(i,t))
            aa=[i]+[sigmoid(z) for z in self.zz[:-1]]
            dw.append([np.dot(d,np.transpose(a)) for a,d in zip(aa,self.dd)])
        return np.sum(db,axis=0),np.sum(dw,axis=0)
    def tr(self,ii,tt,eta):
        dbb,dww=nn.dbw(ii,tt)
        self.bb=[b-eta/len(ii)*db for b,db in zip(self.bb,dbb)]
        self.ww=[w-eta/len(ii)*dw for w,dw in zip(self.ww,dww)]

def sigmoid(x): return 1/(1+np.exp(-x))
def sigmoid1(x): return sigmoid(x)*(1-sigmoid(x))

nn=NN([784,30,10])
tt=fi.lab('train-labels-idx1-ubyte')
ii=fi.img('train-images-idx3-ubyte')
tt1=fi.lab('t10k-labels-idx1-ubyte')
ii1=fi.img('t10k-images-idx3-ubyte')
for i in xrange(len(ii)/20): nn.tr(ii[i*20:(i+1)*20],tt[i*20:(i+1)*20],3)
