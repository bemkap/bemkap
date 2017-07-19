package ob;
import ob.*;
import java.awt.*;
import java.awt.geom.*;
import java.lang.Math;
import java.util.ArrayList;

public class ta{
  public double x=20,y=20,w=270,h=135;
  public ArrayList<bl>bls=new ArrayList<>();
  public ta(){
    for(int i=0;i<2;i++)
      for(int j=0;j<2;j++)
	bls.add(new bl(9+j*w/2,-10+i*(h+10),117,10));
    for(int i=0;i<2;i++)
      bls.add(new bl(-10+i*(w+10),9,10,118));
    for(int i=0;i<2;i++)
      bls.add(new bl(-15,-15+i*(h+25),w+30,5));
    for(int i=0;i<2;i++)
      bls.add(new bl(-15+i*(w+25),-15,5,h+30));
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
