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
  public double th=1;
  public boolean sosc=false,stsc=false;
  public h hos[]=new h[6];
  public ho(){
    for(int i=0;i<3;i++)
      for(int j=0;j<2;j++)
	hos[i*2+j]=new h(14+i*(270-8)/2,14+j*(135-8));
  }
  public void draw(Graphics2D g){
    g.setPaint(new Color(32,32,32));
    g.setStroke(new BasicStroke(1));
    for(h hol:hos)
      g.fill(new Ellipse2D.Double(hol.p.x()-7.5,hol.p.y()-7.5,15,15));
  }				    
  public boolean coll(int i,ba b){
    return b.p.distanceSq(hos[i%6].p)<4*7.5*7.5;
  }
  public void reac(int i,ba b){
    if(b.p.distanceSq(hos[i%6].p)<4*th*th){
      b.sc=true;
      sosc|=b instanceof so;
      stsc|=b instanceof st;
    }else b.f.add(ve.mul(0.1,ve.sub(hos[i%6].p,b.p)));
  }
  public void restart(){
    sosc=stsc=false;
  }
}
