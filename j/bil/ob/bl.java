package ob;
import ob.*;
import java.awt.geom.Rectangle2D;
import java.awt.Graphics2D;
import java.lang.Math;
import java.awt.Color;
import java.util.ArrayList;

public class bl extends Rectangle2D.Double{
  public bl(double x,double y,double w,double h){
    super(x,y,w,h);
  }
  private co coll(ve p1,ve p2,double r,ve q1,ve q2){
    ve b=ve.sub(q2,q1);
    ve n=ve.norm(b);
    double l=ve.dot(ve.sub(p2,q1),n);
    ve a=ve.norm(ve.sub(q2,q1));
    ve c;
    if(l<0) c=q1;
    else if(l*l>b.msqr()) c=q2;
    else c=ve.add(q1,ve.mul(l,n));
    if(ve.sub(p2,c).msqr()<r*r) return new co(c,new ve(a.y(),-a.x()));
    return null;
  }    
  public ArrayList<co>coll(ba b){
    ArrayList<co>c=new ArrayList<>();
    int[]ix={0,1,1,0,1,0,1};
    for(int i=0;i<4;i++){
      co d=coll(b.pp,b,b.r,
		new ve(x+ix[i  ]*width,y+ix[i+3]*height),
		new ve(x+ix[i+2]*width,y+ix[i  ]*height));
      if(d!=null) c.add(d);
    }
    return c;
  }
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    f.setColor(new Color(0,0,0));
    f.draw(this);
    f.dispose();
  }
}
