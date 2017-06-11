package ob;
import ob.*;
import java.util.ArrayList;
import java.lang.Math;
import java.awt.Graphics2D;

public class bs implements dr,up{
  public static enum ST{ST_STO,ST_JST,ST_MOV};
  public ST sta=ST.ST_STO;
  public ArrayList<so> sos=new ArrayList<>();
  public ArrayList<st> sts=new ArrayList<>();
  public so whi,bla;
  public ba fhi=null;
  public bs(){
    double c=Math.cos(Math.PI/6)*14;
    double s=Math.sin(Math.PI/6)*14;
    int[] x={ 0,-1, 1,1, 2,2, 2,-2,-1,0,1, 1,2,2};
    int[] y={-2, 1,-1,3,-2,2,-4, 0,-1,2,1,-3,0,4};
    float[] r={1,1,0,0,1,0,  1,1,1,1,0,0,  1,  1};
    float[] g={1,0,1,1,0,0,1/2,1,0,0,0,1,1/2,1/2};
    float[] b={0,0,1,0,1,1,  0,0,1,0,1,0,  0,  0};
    whi=new so(100,75,1,1,1,-1);
    bla=new so(200,75,0,0,0,-1);
    for(int i=0;i<x.length/2;i++)
      sos.add(new so(200+c*x[i],75+s*y[i],r[i],g[i],b[i],i));
    for(int i=x.length/2;i<x.length;i++)
      sts.add(new st(200+c*x[i],75+s*y[i],r[i],g[i],b[i],i));
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
	if(get(i).coll(get(j))){
	  get(i).reac(get(j));
	  if(i==0) fhi=get(j);
	}
    boolean stop=true;
    for(int i=0;i<size()&&stop;i++) stop&=get(i).f.msqr()<=0||get(i).sc;
    if(stop)
      if(sta==ST.ST_MOV) sta=ST.ST_JST;
      else sta=ST.ST_STO;
    else sta=ST.ST_MOV;
  }
  public void restart(){
    fhi=null;
    sta=ST.ST_MOV;
  }
}
