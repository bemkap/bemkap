import std.stdio;
import std.string;
import std.algorithm;
alias string S;

class G {
  S[] T,NT;
  S[][][S] P;
  this(S t,S nt,S[][] ps){
    T=t.split(" ");
    NT=nt.split(" ");
    foreach(i,tp; ps) foreach(p; tp) P[NT[i]]~=p.split(" ");
  }
}
struct IT { int nt,p,d; } //non-terminal,production,dot
class LR0:G {
  this(S t,S nt,S[][] ps){ super(t,nt,ps); }
  S it2s(IT i){ return P[NT[i.nt]][i.p][i.d]; }
  IT[][]ITEMS(){
    IT[][] I=[CLOSURE([IT(0,0,0)])];
    bool a=true;
    while(a){
      a=false;
      foreach(i; I){
	foreach(nt; NT){ IT[] c=GOTO(i,nt); if(c.length>0){ a=true; I~=c; } }
	foreach( t;  T){ IT[] c=GOTO(i, t); if(c.length>0){ a=true; I~=c; } }
      }
    }
    return I;
  }
  IT[]GOTO(IT[] its,S s){
    IT[] ret;
    foreach(i; its){
      if(i.d<P[NT[i.nt]][i.p].length&&s==it2s(i))
	ret~=CLOSURE([IT(i.nt,i.p,i.d+1)]);
    }
    return ret;
  }
  IT[]CLOSURE(IT[] its){
    bool a=true;
    int[S] I; foreach(i,nt; NT) I[nt]=i;
    while(a){
      a=false;
      foreach(i; its){
	writeln(NT[i.nt],P[NT[i.nt]][i.p],i.d);
	if(i.d<P[NT[i.nt]][i.p].length&&it2s(i) !in P) continue;
	foreach(j,ps; P[it2s(i)]){
	  IT ni={ I[it2s(i)],j,0 };
	  if(!canFind(its,ni)){ a=true; its~=ni; }
	}
      }
    }
    return its;
  }
}

void main(){
  LR0 g=new LR0("+ * ( ) id","E' E T F",
		[["E"],
		 ["E + T","T"],
		 ["T * F","F"],
		 ["( E )","id"]]);
  writeln(g.GOTO(g.CLOSURE([IT(0,0,0)]),"E"));
  //writeln(g.ITEMS());
}
