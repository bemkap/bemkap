package ob;
import ob.*;
import java.awt.*;
import java.awt.geom.*;
import java.lang.Math;
import javax.imageio.*;
import java.awt.image.*;
import java.net.*;
import java.io.IOException;

public class ba extends ve{
  public ve pp,f=new ve(0,0);
  public double W=0;
  public Paint c=new Color(0,0,0);
  public static double r=6;
  public boolean sc=false,so=true;
  public int n;
  public BufferedImage img=null;
  public ba(double x,double y){
    super(x,y);
    pp=new ve(x,y);
  }
  public ba(double x,double y,int m,String fn,boolean s){
    this(x,y);
    n=m; so=s;
    URL u=null;
    try{u=new URL("file","",fn);}
    catch(MalformedURLException e){}
    try{img=ImageIO.read(u);}
    catch(IOException e){}
  }
  public boolean coll(ba b){
    return !sc&&distanceSq(b)<4*r*r;
  }
  public void reac(ba b){
    ve v=ve.sub(this,b);
    ve n=ve.mul(r-v.mag()/2,ve.norm(v));
    v.mul(ve.dot(ve.sub(f,b.f),v)/v.msqr());
    f.sub(v);
    b.f.add(v);
    b.sub(n);
    add(n);
  }
  public void draw(Graphics2D g){
    if(!sc){
      Graphics2D f=(Graphics2D)g.create();
      f.setPaint(c);
      if(img==null) f.fill(new Ellipse2D.Double(x-r,y-r,2*r,2*r));
      else f.drawImage(img,null,(int)(x-r),(int)(y-r));
      f.dispose();
    }
  }    
  public void upda(){
    pp.setLocation(x,y);
    if(!sc){
      f.rot(W);
      add(f);
      f.mul(f.msqr()<0.05?0:0.96);
    }
  }
}
