import json
import math
class rating:
    def __init__(self,r_fn,m_fn):
        r_fd=open(r_fn,"r")
        m_fn=open(m_fn,"r")
        self.d={}
        for i in json.load(r_fd):
            self.d.setdefault(i['userId'],{})
            self.d[i['userId']][i['movieId']]=i['rating']
        r_fd.close()
        self.m=dict((i['movieId'],i['title']) for i in json.load(m_fn))
        m_fn.close()
    def distance(self,met,u1,u2):
        s=set(self.d[u1].keys())&set(self.d[u2].keys())
        return met([self.d[u1][x] for x in s],[self.d[u2][x] for x in s])
    def nearest(self,met,u1,n):
        l=[(u2,self.distance(met,u1,u2)) for u2 in self.d if u1!=u2]
        return dict(sorted(l,key=lambda x:x[1],reverse=True)[:n])
    def recommend(self,met,u1,n):
        n=self.nearest(met,u1,n)
        r,s={},{}
        for k in n:
            for m in self.d[k]:
                r.setdefault(m,0)
                s.setdefault(m,0)
                r[m]+=self.d[k][m]*n[k]
                s[m]+=n[k]
        return sorted([(r[m]/s[m],self.m[m]) for m in r if not self.d[u1].get(m)],reverse=True)

def euclidean(p1,p2):
    return 1/(1+math.sqrt(sum(pow(x-y,2) for x,y in zip(p1,p2))))

def pearson(p1,p2):
    if len(p1)==0: return 0
    su1=sum(p1)
    su2=sum(p2)
    sq1=sum(pow(x,2) for x in p1)
    sq2=sum(pow(y,2) for y in p2)
    sup=sum(x*y for x,y in zip(p1,p2))
    num=sup-(su1*su2/len(p1))
    den=math.sqrt((sq1-pow(su1,2)/len(p1))*(sq2-pow(su2,2)/len(p1)))
    return 0 if den==0 else num/den

r=rating("ratings.json","movies.json")
for i in r.recommend(pearson,672,5)[:10]: print(i[1])
