from pysqlite2 import dbapi2 as sqlite
from datetime import date
import time

class builder:
    def __init__(self,tbname,fields,relations):
        self.tbname=tbname
        self.fields=fields
        self.relations=relations
    def select(self,field="*",where=None):
        return "select %s from %s"%(field,self.tbname)+(" where %s"%where if where!=None else "")
    def insert(self,values):
        return "insert into %s(%s) values ('%s')"%(self.tbname,','.join(self.fields),"','".join(map(str,values)))

class bc:
    def __init__(self):
        self.con=sqlite.connect('bcc.db')
        self.builders={
            "cate":builder("cate",["cate"],{}),
            "ingr":builder("ingr",["ingr","cateid"],{"cateid":"cate"}),
            "cocc":builder("cocc",["cocc"],{}),
            "plat":builder("plat",["plat","coccid"],{"coccid":"cocc"}),
            "prep":builder("prep",["platid","ingrid"],{"platid":"plat","ingrid":"ingr"}),
            "bita":builder("bita",["fech","almu","platid"],{"platid":"plat"})
        }
    def __del__(self):
        self.con.close()
    def dbcommit(self):
        self.con.commit()
    def createtables(self):
        for k in self.builders:
            self.con.execute("create table %s("%k+','.join(self.builders[k].fields)+")")
            self.con.execute("create index %sidx on %s("%(k,k)+','.join(self.builders[k].fields)+")")
        self.dbcommit()
    def insert(self,builder,values):
        re=self.builders[builder].relations
        fi=self.builders[builder].fields
        r_values=[self.getid(re[fi[i]],"%s='%s'"%(re[fi[i]],values[i])) if fi[i] in re else values[i] for i in xrange(len(values))]
        re=self.con.execute(self.builders[builder].insert(r_values));
        self.dbcommit()
        return re.lastrowid
    def select(self,builder,field=None,where=None):
        field=','.join(self.builders[builder].fields) if field==None else field
        rs=self.con.execute(self.builders[builder].select(field,where)).fetchall()
        re=self.builders[builder].relations
        fi=self.builders[builder].fields
        return [[self.select(re[fi[i]],where="rowid='%s'"%d[i])[0][0] if fi[i] in re else d[i] for i in xrange(len(d))] for d in rs]
    def getid(self,builder,where):
        return self.select(builder,"rowid",where)[0][0]
    def addrec(self,plat,almu,dia=None):
        return self.insert("bita",[date.fromtimestamp(time.time()).isoformat() if dia==None else dia,almu,plat])
    def printt(self,builder):
        print "\n".join(''.join("%30s"%s for s in r) for r in self.select(builder))
    def printb(self,dfrom="2000-01-01",dto="2099-12-31"):
        di={}
        for d in self.select("bita",where="fech>='%s' and fech<='%s'"%(dfrom,dto)):
            di.setdefault(d[0],[[],[]])
            di[d[0]][int(d[1])].append(d[2])
        for d in sorted(di.keys()):
            print d
            for i in xrange(max(len(di[d][0]),len(di[d][1]))):
                p1=di[d][1][i] if i<len(di[d][1]) else ''
                p2=di[d][0][i] if i<len(di[d][0]) else ''
                print "%30s %30s"%(p1,p2)
