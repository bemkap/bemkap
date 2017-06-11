package ob;
import java.awt.*;
import java.awt.geom.*;
import ob.*;

public class ta implements dr{
  private double x=10,y=10,w=270,h=135;
  public void draw(Graphics2D g){
    g.setColor(new Color(0,160,0));
    g.fill(new RoundRectangle2D.Double(x,y,w,h,5,5));
    g.setPaint(new Color(0,0,0));
    g.setStroke(new BasicStroke(10));
    g.draw(new RoundRectangle2D.Double(x,y,w,h,5,5));
  }
}
