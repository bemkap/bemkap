package ob;
import ob.*;
import java.util.ArrayList;
import java.lang.Math;
import java.awt.Graphics2D;

public class bs{
  public static enum ST{ST_STO,ST_JST,ST_MOV};
  public ST sta=ST.ST_STO;
  public ArrayList<ba> bas=new ArrayList<>();
  public ba whi,bla;
  public Boolean fso=null;
  public bs(){
    double c=Math.cos(Math.PI/6)*12;
    double s=Math.sin(Math.PI/6)*12;
    int[]x={ 0,-1, 1,1, 2,2, 2,-2,-1,0,1, 1,2,2};
    int[]y={-2, 1,-1,3,-2,2,-4, 0,-1,2,1,-3,0,4};
    whi=new ba(66.5,66.5,-1,"img/0.png",true);
    bla=new ba(200,66.5,-1,"img/8.png",true);
    for(int i=0;i<x.length;i++){
      String nm=String.format("img/%d.png",i+1+(i>=7?1:0));
      bas.add(new ba(200+c*x[i],66.5+s*y[i],i,nm,i>=x.length/2));
    }
  }
  public ba get(int i){
    switch(i){
    case  0: return whi;
    case  1: return bla;
    default: return bas.get(i-2);
    }
  }
  public int size(){
    return bas.size()+2;
  }
  public void draw(Graphics2D g){
    whi.draw(g); bla.draw(g);
    for(ba bal:bas) bal.draw(g);
  }
  public void upda(){
    for(int i=0;i<size();i++) get(i).upda();
    for(int i=0;i<size();i++)
      for(int j=i+1;j<size();j++)
	if(!get(i).sc&&!get(j).sc&&get(i).coll(get(j))){
	  get(i).reac(get(j));
	  if(i==0&&fso==null) fso=get(j).so;
	}
    boolean stop=true;
    for(int i=0;i<size()&&stop;i++) stop&=get(i).f.msqr()<=0||get(i).sc;
    if(stop)
      if(sta==ST.ST_MOV) sta=ST.ST_JST;
      else sta=ST.ST_STO;
    else sta=ST.ST_MOV;
  }
  public ArrayList<Integer>scored(boolean so){
    ArrayList<Integer>r=new ArrayList<>();
    for(ba bal:bas) if(bal.sc&&bal.so==so) r.add(bal.n);
    return r;
  }
}
