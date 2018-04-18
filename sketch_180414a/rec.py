import json
import math
class rating:
    def __init__(self,fn):
        fd=open(fn,"r")
        self.d={}
        for i in json.load(fd):
            if not self.d.get(i['userId']): self.d[i['userId']]={}
            self.d[i['userId']][i['movieId']]=i['rating']
        fd.close()
    def euclidean(self,u1,u2):
        s1=set(self.d[u1].keys())
        s2=set(self.d[u2].keys())
        su=sum([pow(self.d[u1][x]-self.d[u2][x],2) for x in s1&s2])
        return 1/(1+math.sqrt(su))
    def nearest(self,u1,n):
        l=[(u2,self.euclidean(u1,u2)) for u2 in self.d if u1!=u2]
        return dict(sorted(l,key=lambda x:x[1],reverse=True)[:n])
    def recommend(self,u1,n):
        n=self.nearest(u1,n)
        r,s={},{}
        for k in n:
            for m in self.d[k]:
                r.setdefault(m,0)
                s.setdefault(m,0)
                r[m]+=self.d[k][m]*n[k]
                s[m]+=n[k]
        return sorted([(r[m]/s[m],m) for m in r],reverse=True)

r=rating("ratings.json")
print(r.recommend(672,5))
