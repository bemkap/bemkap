package ob;
import ob.*;
import java.awt.*;
import java.awt.geom.*;
import java.lang.Math.*;

public class cu implements dr,up{
  public ve p;
  public double d=0,r=0;
  public boolean v=true;
  public cu(double x,double y){
    p=new ve(x,y);
  }
  public void draw(Graphics2D g){
    g.setPaint(new Color(0,0,0));
    if(v){
      Double dx1=Math.cos(d)*80;
      Double dy1=Math.sin(d)*80;
      Double dx2=Math.cos(d)*10;
      Double dy2=Math.sin(d)*10;
      g.draw(new Line2D.Double(p.x()-dx1,p.y()-dy1,
			       p.x()-dx2,p.y()-dy2));
      g.setStroke(new BasicStroke(1,BasicStroke.CAP_BUTT,BasicStroke.JOIN_BEVEL,0,new float[]{2},0));
      g.draw(new Line2D.Double(p.x()+dx2,p.y()+dy2,
			       p.x()+dx1*2,p.y()+dy1*2));
    }
  }
  public void upda(){d+=r;}
  public void rot(double dd){r=dd;}
  public void setp(double x,double y){p.setLocation(x,y);}
}
