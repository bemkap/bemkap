package ob;
import ob.*;
import java.awt.*;
import java.awt.geom.*;
import java.lang.Math;

public class cu extends ve{
  public double d=0;
  public boolean v=true;
  public cu(double x,double y){
    super(x,y);
  }
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    if(v){
      double dx1=Math.cos(d)*80;
      double dy1=Math.sin(d)*80;
      double dx2=Math.cos(d)*10;
      double dy2=Math.sin(d)*10;
      f.draw(new Line2D.Double(x-dx1,y-dy1,x-dx2,y-dy2));
      f.setStroke(new BasicStroke(1,BasicStroke.CAP_BUTT,BasicStroke.JOIN_BEVEL,0,new float[]{2},0));
      f.draw(new Line2D.Double(x+dx2,y+dy2,x+dx1*2,y+dy1*2));
      
    }
    f.dispose();
  }
}
