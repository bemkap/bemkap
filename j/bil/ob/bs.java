package ob;
import ob.*;
import java.util.ArrayList;
import java.lang.Math;
import java.awt.Graphics2D;

public class bs{
  public static enum ST{ST_STO,ST_JST,ST_MOV};
  public ST sta=ST.ST_STO;
  public ArrayList<so> sos=new ArrayList<>();
  public ArrayList<st> sts=new ArrayList<>();
  public so whi,bla;
  public Boolean fso=null;
  public bs(){
    double c=Math.cos(Math.PI/6)*12;
    double s=Math.sin(Math.PI/6)*12;
    int[]x={ 0,-1, 1,1, 2,2, 2,-2,-1,0,1, 1,2,2};
    int[]y={-2, 1,-1,3,-2,2,-4, 0,-1,2,1,-3,0,4};
    whi=new so(66.5,66.5,1,1,1,-1);
    bla=new so(200,66.5,-1,"img/8.png");
    for(int i=0;i<x.length/2;i++)
      sos.add(new so(200+c*x[i],66.5+s*y[i],i,String.format("img/%d.png",i+1)));
    for(int i=x.length/2;i<x.length;i++)
      sts.add(new st(200+c*x[i],66.5+s*y[i],i,String.format("img/%d.png",9+i-x.length/2)));
  }
  public ba get(int i){
    ba b;
    switch(i){
    case  0:b=whi; break;
    case  1:b=bla; break;
    default:b=i>=sos.size()+2?sts.get(i-sos.size()-2):sos.get(i-2);
    }
    return b;
  }
  public int size(){
    return sos.size()+sts.size()+2;
  }
  public void draw(Graphics2D g){
    whi.draw(g); bla.draw(g);
    for(so sol:sos) sol.draw(g);
    for(st str:sts) str.draw(g);
  }
  public void upda(){
    whi.upda(); bla.upda();
    for(so sol:sos) sol.upda();
    for(st str:sts) str.upda();
    for(int i=0;i<size()-1;i++)
      for(int j=i+1;j<size();j++)
	if(!get(i).sc&&!get(j).sc&&get(i).coll(get(j))){
	  get(i).reac(get(j));
	  if(i==0&&fso==null) fso=get(j) instanceof so;
	}
    boolean stop=true;
    for(int i=0;i<size()&&stop;i++) stop&=get(i).f.msqr()<=0||get(i).sc;
    if(stop)
      if(sta==ST.ST_MOV) sta=ST.ST_JST;
      else sta=ST.ST_STO;
    else sta=ST.ST_MOV;
  }
  public int left(boolean so){
    int r=0;
    if(so) for(so sol:sos) r+=sol.sc?1:0;
    else for(st str:sts) r+=str.sc?1:0;
    return r;
  }
}
