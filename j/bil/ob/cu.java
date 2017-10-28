package ob;
import ob.*;
import java.awt.*;
import java.awt.geom.*;
import java.lang.Math;
import java.awt.event.MouseEvent;
import java.awt.event.KeyEvent;

public class cu extends ve{
  public boolean v=true;
  public ve tp,ptp;
  public double spi=0,dspi=0;
  public cu(double x,double y){
    super(x,y);
    tp=new ve(x,y);
    ptp=new ve(x,y);
  }
  public void draw(Graphics2D g){
    if(v){
      Graphics2D f=(Graphics2D)g.create();
      ve sp=ve.sca(25,ve.sub(tp,this));
      ve tp1=ve.add(ve.sca(-spi,new ve(-sp.y(),sp.x())),tp);
      f.draw(new Line2D.Double(ve.sub(tp1,sp),ve.add(tp1,sp)));
      f.dispose();
    }
  }
  public boolean coll(ba b){
    return ve.sub(tp,b).msqr()<Math.pow(b.r+25,2);
  }
  public void reac(ba b){
    b.f=ve.mul(2,ve.sub(tp,ptp));
    b.setLocation(ve.add(tp,ve.sca(31,ve.sub(this,tp))));
    v=false;
  }
  public int mouseMoved(MouseEvent e,double sca,int ox,int oy){
    ptp.setLocation(tp);
    tp.setLocation(e.getX()/sca-ox,e.getY()/sca-oy);
    return 0;
  }
  public int keyPressed(KeyEvent e){
    switch(e.getKeyCode()){
    case KeyEvent.VK_LEFT: dspi=-0.5; break;
    case KeyEvent.VK_RIGHT: dspi=0.5;
    }
    return 0;
  }
  public int keyReleased(KeyEvent e){
    switch(e.getKeyCode()){
    case KeyEvent.VK_LEFT: case KeyEvent.VK_RIGHT: dspi=0;
    }
    return 0;
  }
  public void upda(){
    spi=Math.max(-ba.r,Math.min(ba.r,spi+dspi));
  }
}
