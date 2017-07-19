package ob;
import ob.*;
import java.awt.event.KeyEvent;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;
import java.awt.geom.Rectangle2D;
import java.awt.geom.Line2D;

public class na implements gs{
  public int cn=0;
  public String ns[]={"",""};
  public ta tab=new ta();
  public int upda(){
    return 0;
  }
  public void paint(Graphics2D g,double sca,int ox,int oy){
    g.translate(ox,oy);
    tab.draw(g);
    g.drawString(ns[0],100,60);
    g.draw(new Line2D.Double(100,65,175,65));
    g.drawString(ns[1],100,80);
    g.drawString(">",85,60+cn*20);
    g.draw(new Line2D.Double(100,85,175,85));
  }
  public int key(KeyEvent e){
    switch(e.getKeyCode()){
    case KeyEvent.VK_ENTER: return 1;
    case KeyEvent.VK_DOWN: cn=1; break;
    case KeyEvent.VK_UP: cn=0; break;
    case KeyEvent.VK_BACK_SPACE:
      ns[cn]=ns[cn].substring(0,ns[cn].length()-1); break;
    default: if(e.getKeyCode()>=KeyEvent.VK_A&&
		e.getKeyCode()<=KeyEvent.VK_Z)
	ns[cn]=(ns[cn]+e.getKeyChar());
    }
    return 0;
  }
  public int mouse(MouseEvent e,double sca,int ox,int oy){
    return 0;
  }
}
