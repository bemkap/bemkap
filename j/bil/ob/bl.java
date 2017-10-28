package ob;
import ob.*;
import java.awt.geom.Rectangle2D;
import java.awt.Graphics2D;
import java.lang.Math;
import java.awt.Color;
import java.util.ArrayList;
import java.awt.geom.Point2D;
import java.awt.geom.Path2D;

public class bl extends ArrayList<Point2D.Double>{
  // public bl(double x,double y,double w,double h){
  //   super(x,y,w,h);
  // }
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
    // int[]ix={0,1,1,0,1,0,1};
    for(int i=0;i<size();i++){
      co d=coll(b.pp,b,b.r,new ve(get(i)),new ve(get((i+1)%size())));
      if(d!=null) c.add(d);
    }
    // for(int i=0;i<4;i++){
    //   co d=coll(b.pp,b,b.r,
    // 		new ve(x+ix[i  ]*width,y+ix[i+3]*height),
    // 		new ve(x+ix[i+2]*width,y+ix[i  ]*height));
    //   if(d!=null) c.add(d);
    // }
    return c;
  }
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    Path2D.Double p=new Path2D.Double();
    f.setColor(new Color(0,0,0));
    if(size()>0){
      p.moveTo(get(0).getX(),get(0).getY());
      for(int i=1;i<size();i++) p.lineTo(get(i).getX(),get(i).getY());
      p.closePath();
    }
    f.draw(p);
    f.dispose();
  }
}
