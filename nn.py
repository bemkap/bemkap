import numpy as np
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
        self.dd=[(self.ff(i)-t)*sigmoid1(self.zz[-1])]
        for i in xrange(len(self.ww)-1):
            self.dd.insert(0,np.dot(np.transpose(self.ww[-i+1]),self.dd[-1])*
                           sigmoid1(self.zz[-i]))
        return self.dd
    def dbw(self,ii,tt):
        db=[[b+d for b,d in zip(self.bb,self.dl(i,t))] for i,t in zip(ii,tt)]
        aa=[i]+[sigmoid(z) for z in self.zz[:-1]]
        dw=[[np.dot(d,np.transpose(a)) for a,d in zip(aa,self.dd)] for i,t in zip(ii,tt)]
        return np.sum(db,axis=0),np.sum(dw,axis=0)
    def tr(self,ii,tt,eta):
        dbb,dww=nn.dbw(ii,tt)
        self.bb=[b-eta/len(ii)*db for b,db in zip(self.bb,dbb)]
        self.ww=[w-eta/len(ii)*dw for w,dw in zip(self.ww,dww)]

def sigmoid(x): return 1/(1+np.exp(-x))
def sigmoid1(x): return sigmoid(x)*(1-sigmoid(x))

nn=NN([8,4,2])
ii=[]
tt=[]
for i in xrange(10):
    ii.append(np.random.rand(8,1))
    tt.append(np.random.rand(2,1))
nn.tr(ii,tt,0.5)
