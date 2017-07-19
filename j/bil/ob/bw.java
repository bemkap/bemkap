package ob;
import ob.*;
import java.awt.geom.Point2D;
import java.awt.geom.Ellipse2D;
import java.awt.Graphics2D;
import java.awt.event.KeyEvent;

public class bw extends ve{
  public ve w=new ve(0,0);
  public static double r=12;
  public bw(double x,double y){
    super(x,y);
  }
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    f.draw(new Ellipse2D.Double(x-r,y-r,2*r,2*r));
    f.draw(new Ellipse2D.Double(x+w.x()-1,y+w.y()-1,2,2));
    f.dispose();
  }
  public void key(KeyEvent e){
    switch(e.getKeyCode()){
    case KeyEvent.VK_RIGHT: w.add(new ve(1,0)); break;
    case KeyEvent.VK_LEFT: w.sub(new ve(1,0)); break;
    case KeyEvent.VK_DOWN: w.add(new ve(0,1)); break;
    case KeyEvent.VK_UP: w.sub(new ve(0,1));
    }
    if(w.msqr()>r*r) w=ve.mul(r,ve.norm(w));
  }
}
