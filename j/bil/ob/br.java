package ob;
import java.awt.geom.Rectangle2D;
import java.awt.Graphics2D;
import java.awt.Color;
import java.lang.Math;
import java.awt.BasicStroke;

public class br{
  public double cp=0,dp=0;
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    f.translate(0,160);
    f.setColor(new Color(63,255,63));
    f.fill(new Rectangle2D.Double(-1,0,2.7*cp,5));
    f.setColor(new Color(0,0,0));
    f.draw(new Rectangle2D.Double(0,0,270,5));
    f.dispose();
  }
  public void upda(){
    cp+=dp;
    if(cp>100||cp<0){
      cp=Math.min(100,Math.max(0,cp));
      dp*=-1;
    }
  }
  public boolean pushed(){
    return dp!=0;
  }
  public void first(){
    dp=2;
    cp=0;
  }
  public void stop(){
    dp=0;
  }
}
