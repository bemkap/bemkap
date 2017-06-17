package ob;
import ob.*;
import java.awt.geom.Ellipse2D;
import java.awt.Graphics2D;
import java.awt.Color;
import java.awt.BasicStroke;

public class ho{
  public class h{
    public ve p;
    public h(double x,double y){
      p=new ve(x,y);
    }
  }
  public double th=2,r=8;
  public boolean sosc=false,stsc=false;
  public final int n=7;
  public h hos[]=new h[n];
  public ho(){
    for(int i=0;i<3;i++)
      for(int j=0;j<2;j++)
	hos[i*2+j]=new h(10+i*270/2,10+j*135);
    hos[6]=new h(130,70);
  }
  public void draw(Graphics2D g){
    g.setPaint(new Color(32,32,32));
    g.setStroke(new BasicStroke(1));
    for(h hol:hos)
      g.fill(new Ellipse2D.Double(hol.p.x()-r,hol.p.y()-r,r*2,r*2));
  }				    
  public boolean coll(int i,ba b){
    return b.p.distanceSq(hos[i%n].p)<Math.pow(b.r+r,2);
  }
  public void reac(int i,ba b){
    if(b.p.distanceSq(hos[i%n].p)<Math.pow(th,2)){
      b.sc=true;
      sosc|=b instanceof so;
      stsc|=b instanceof st;
    }else{
      ve v=ve.sub(hos[i%n].p,b.p);
      b.f.rot(Math.PI/90*Math.signum(v.angle()-b.f.angle()));
      b.f.mul(1.01);
    }
  }
  public void restart(){
    sosc=stsc=false;
  }
}
