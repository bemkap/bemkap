package ob;
import ob.*;
import java.awt.*;
import java.awt.geom.*;
import java.lang.Math;
import java.util.ArrayList;

public class ta{
  public double x=0,y=0,w=270,h=135;
  public ArrayList<bl>bls=new ArrayList<>();
  public ta(){
    for(int i=0;i<6;i++) bls.add(new bl());
    bls.get(0).add(new Point2D.Double(x-15,y-5));
    bls.get(0).add(new Point2D.Double(x,y+10));
    bls.get(0).add(new Point2D.Double(x,h-y-10));
    bls.get(0).add(new Point2D.Double(x-15,h-y+5));
    bls.get(1).add(new Point2D.Double(x+w,y+10));
    bls.get(1).add(new Point2D.Double(x+w+15,y-5));
    bls.get(1).add(new Point2D.Double(x+w+15,h-y+5));
    bls.get(1).add(new Point2D.Double(x+w,h-y-10));
    bls.get(2).add(new Point2D.Double(x-5,y-15));
    bls.get(2).add(new Point2D.Double(x+w/2-ba.r,y-15));
    bls.get(2).add(new Point2D.Double(x+w/2-ba.r-2.5,y));
    bls.get(2).add(new Point2D.Double(x+10,y));
    bls.get(3).add(new Point2D.Double(x+w/2+ba.r,y-15));
    bls.get(3).add(new Point2D.Double(x+w+5,y-15));
    bls.get(3).add(new Point2D.Double(x+w-10,y));
    bls.get(3).add(new Point2D.Double(x+w/2+ba.r+2.5,y));
    bls.get(4).add(new Point2D.Double(x+10,y+h));
    bls.get(4).add(new Point2D.Double(x+w/2-ba.r-2.5,y+h));
    bls.get(4).add(new Point2D.Double(x+w/2-ba.r,y+h+15));
    bls.get(4).add(new Point2D.Double(x-5,y+h+15));
    bls.get(5).add(new Point2D.Double(x+w/2+ba.r+2.5,y+h));
    bls.get(5).add(new Point2D.Double(x+w-10,y+h));
    bls.get(5).add(new Point2D.Double(x+w+5,y+h+15));
    bls.get(5).add(new Point2D.Double(x+w/2+ba.r,y+h+15));
  }
  public ArrayList<co>coll(ba b){
    ArrayList<co>c=new ArrayList<>();
    for(int i=0;i<bls.size();i++)
      c.addAll(bls.get(i).coll(b));
    return c;
  }
  public void reac(ArrayList<co>cs,ba b){
    for(co c:cs){
      b.f.sub(ve.mul(2*ve.dot(b.f,c.n),c.n));
      b.setLocation(ve.add(c.v,ve.mul(b.r,c.n)));
    }
  }
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    f.setColor(new Color(96,0,0));
    f.fill(new RoundRectangle2D.Double(-15,-15,w+30,h+30,15,15));
    f.setColor(new Color(0,160,0));
    f.fill(new RoundRectangle2D.Double(0,0,w,h,2,2));
    for(bl blo:bls) blo.draw(g);
    f.dispose();
  }
}
