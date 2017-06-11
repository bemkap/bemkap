package ob;
import ob.dr;
import java.awt.geom.Rectangle2D;
import java.awt.Graphics2D;
import java.awt.Color;
import java.lang.Math;

public class br implements dr,up{
  public double p=0,dp=0;
  public void draw(Graphics2D g){
    g.setPaint(new Color(0,0,0));
    g.draw(new Rectangle2D.Double(10,155,270,5));
    g.setPaint(new Color(0,0,255));
    g.fill(new Rectangle2D.Double(10,155,2.7*p,5));
  }
  public void upda(){
    p+=dp;
    if(p>100||p<0){
      p=Math.min(100,Math.max(0,p));
      dp*=-1;
    }
  }
  public boolean pushed(){
    return dp!=0;
  }
  public void start(){
    dp=2;
  }
  public double stop(){
    double t=p;
    p=dp=0;
    return t;
  }
}
