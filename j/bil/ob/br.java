package ob;
import ob.dr;
import java.awt.geom.Rectangle2D;
import java.awt.Graphics2D;
import java.awt.Color;
import java.lang.Math;
import java.awt.BasicStroke;

public class br implements dr,up{
  public double cp=0,p1=0,p2=0,dp=0;
  public int sta=0;
  public void draw(Graphics2D g){
    g.setStroke(new BasicStroke(1));
    g.setColor(new Color(127,127,255));
    g.fill(new Rectangle2D.Double(20,165,2.5*(p1>0?p1:cp),5));
    g.setColor(new Color(127,127,127));
    g.fill(new Rectangle2D.Double(19+2.5*cp,160,2,15));
    g.setColor(new Color(0,0,0));
    g.draw(new Rectangle2D.Double(10,165,270,5));
  }
  public void upda(){
    cp+=dp;
    if(cp>100||cp<-4){
      cp=Math.min(100,Math.max(-4,cp));
      dp*=-1;
    }
  }
  public boolean pushed(){
    return dp!=0;
  }
  public void first(){
    dp=2;
    sta=1;
    cp=p1=0;
  }
  public void second(){
    sta=2;
    p1=cp;
  }
  public void stop(){
    sta=0;
    p2=cp;
    dp=0;
  }
}
