import json
import math
import sys
class rating:
    def __init__(self,r_fns,m_fn):
        self.d={}
        for r_fn in r_fns:
            with open(r_fn,"r") as r_fd:
                for i in json.load(r_fd):
                    self.d.setdefault(i['userId'],{})
                    self.d[i['userId']][i['movieId']]=i['rating']
        with open(m_fn,"r") as m_fn:
            self.m=dict((i['movieId'],(i['title'],i['genres'].split("|"))) for i in json.load(m_fn))
    def distance(self,met,u1,u2):
        s=set(self.d[u1].keys())&set(self.d[u2].keys())
        return met(*zip(*((self.d[u1][x],self.d[u2][x]) for x in s)))
    def nearest(self,met,u1,n):
        l=[(u2,self.distance(met,u1,u2)) for u2 in self.d if u1!=u2]
        return dict(sorted(l,key=lambda x:x[1],reverse=True)[:n])
    def recommend(self,met,u1,n):
        nn=self.nearest(met,u1,n)
        r,s={},{}
        for k in nn:
            for m in self.d[k]:
                r.setdefault(m,0)
                s.setdefault(m,0)
                r[m]+=self.d[k][m]*nn[k]
                s[m]+=nn[k]
        return sorted([(r[m]/s[m],self.m[m]) for m in r if not self.d[u1].get(m)],reverse=True)

def euclidean(p1=[],p2=[]):
    return 1/(1+math.sqrt(sum(pow(x-y,2) for x,y in zip(p1,p2))))

def pearson(p1=[],p2=[]):
    if len(p1)==0: return 0
    su1=sum(p1)
    su2=sum(p2)
    sq1=sum(pow(x,2) for x in p1)
    sq2=sum(pow(y,2) for y in p2)
    sup=sum(x*y for x,y in zip(p1,p2))
    num=sup-(su1*su2/len(p1))
    den=math.sqrt((sq1-pow(su1,2)/len(p1))*(sq2-pow(su2,2)/len(p1)))
    return 0 if den==0 else num/den

n=20 if len(sys.argv)<2 else int(sys.argv[1])
f=(lambda m:sys.argv[2] in m[1][1]) if len(sys.argv)>2 else (lambda m:True)
r=rating(["ratings.json","ratings1.json"],"movies.json")
for i in filter(f,r.recommend(pearson,0,5))[:n]: print(i[1][0])
