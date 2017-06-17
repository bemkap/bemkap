package ob;
import java.awt.*;
import java.awt.geom.*;
import java.lang.Math;
import ob.dr;
import ob.ve;

public class ba implements dr,up{
  public ve p,f=new ve(0,0);
  public Paint c=new Color(0,0,0);
  public double r=6;
  public boolean sc=false;
  public int n;
  public ba(double x,double y,int nn){
    p=new ve(x,y);
    n=nn;
  }
  public boolean coll(ba b){
    return !sc&&p.distanceSq(b.p)<4*r*r;
  }
  public boolean coll(ta t){
    boolean a=x()>t.x+t.w-r||x()<t.x+r;
    boolean b=y()>t.y+t.h-r||y()<t.y+r;
    if(a) f.mul(-1,1);
    if(b) f.mul(1,-1);
    return !sc&&(a||b);
  }
  public void reac(ba b){
    ve v=ve.sub(p,b.p);
    b.p=ve.sub(p,ve.mul(2*r,ve.norm(v)));
    v.mul(ve.dot(ve.sub(f,b.f),v)/v.msqr());
    ve w=ve.sub(b.p,p);
    w.mul(ve.dot(ve.sub(b.f,f),w)/w.msqr());
    f.sub(v);
    b.setf(ve.sub(b.f,w));
  }
  public void reac(ta t){
    setp(Math.min(t.x+t.w-r,Math.max(x(),t.x+r)),
	 Math.min(t.y+t.h-r,Math.max(y(),t.y+r)));
  }
  public void draw(Graphics2D g){
    g.setPaint(c);
    Ellipse2D e;
    e=sc?new Ellipse2D.Double(100+n*15,200,2*r,2*r):
      new Ellipse2D.Double(x()-r,y()-r,2*r,2*r);
    g.fill(e);
    g.setColor(new Color(0,0,0));
    g.draw(e);
  }
  public void upda(){
    if(!sc){
      p.add(f);
      f.mul(0.95);
      if(f.msqr()<0.1) f.mul(0);
    }
  }
  public double x(){return p.x();}
  public double y(){return p.y();}
  public void setp(double x,double y){p.setLocation(x,y);}
  public void setp(ve v){p=v;}
  public void setf(double x,double y){f.setLocation(x,y);}
  public void setf(ve v){f=v;}
}
