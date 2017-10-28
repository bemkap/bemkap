package ob;
import ob.*;
import java.awt.geom.Ellipse2D;
import java.awt.Graphics2D;
import java.awt.Color;
import java.awt.BasicStroke;

public class ho{
  public double r=9;
  public boolean sosc=false,stsc=false;
  public ve hos[]=new ve[6];
  public ho(double w,double h){
    for(int i=0;i<2;i++){
      for(int j=0;j<2;j++)
	hos[i*2+j]=new ve(i*w,j*h);
      hos[4+i]=new ve(w/2,-5+i*(h+10));
    }
  }
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    f.setPaint(new Color(32,32,32));
    f.setStroke(new BasicStroke(1));
    for(ve hol:hos)
      f.fill(new Ellipse2D.Double(hol.x()-r,hol.y()-r,r*2,r*2));
    f.dispose();
  }				    
  public boolean coll(int i,ba b){
    return b.distanceSq(hos[i%6])<Math.pow(b.r+r,2);
  }
  public void reac(int i,ba b){
    if(!b.sc&&b.distanceSq(hos[i%6])<Math.pow(r-b.r,2)){
      b.sc=true;
      sosc|=b.so;
      stsc|=!b.so;
    }else{
      ve v=ve.sub(hos[i%6],b);
      b.f.rot(Math.PI/60*Math.signum(v.angle()-b.f.angle()));
      b.f.add(ve.mul(1/v.msqr(),v));
    }
  }
}
