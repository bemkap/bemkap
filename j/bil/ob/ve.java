package ob;
import java.awt.geom.Point2D;
import java.lang.Math;

public class ve extends Point2D.Double{
  public ve(double x,double y){
    super(x,y);
  }
  @Override
  public void setLocation(double x,double y){
    this.x=x;
    this.y=y;
  }
  public static ve add(ve v,ve w){
    return new ve(v.getX()+w.getX(),v.getY()+w.getY());
  }
  public void add(ve v){
    setLocation(getX()+v.getX(),getY()+v.getY());
  }
  public static ve mul(double a,ve v){
    return new ve(a*v.getX(),a*v.getY());
  }
  public static ve mul(double a,double b,ve v){
    return new ve(a*v.getX(),a*v.getY());
  }
  public void mul(double a){
    setLocation(a*getX(),a*getY());
  }
  public void mul(double a,double b){
    setLocation(a*getX(),b*getY());
  }
  public static ve sub(ve v,ve w){
    return new ve(v.getX()-w.getX(),v.getY()-w.getY());
  }
  public void sub(ve v){
    setLocation(getX()-v.getX(),getY()-v.getY());
  }
  public static double dot(ve v,ve w){
    return v.getX()*w.getX()+v.getY()*w.getY();
  }
  public void rot(double a){
    setLocation(getX()*Math.cos(a)-getY()*Math.sin(a),
		getX()*Math.sin(a)+getY()*Math.cos(a));
  }
  public double msqr(){
    return distanceSq(0,0);
  }
  public double angle(){
    return Math.atan2(getY(),getX());
  }
  public static ve norm(ve v){
    double l=Math.sqrt(v.msqr());
    return ve.mul(1/l,v);
  }
  public void norm(){
    double l=Math.sqrt(msqr());
    setLocation(x/l,y/l);
  }
  public double x(){
    return getX();
  }
  public double y(){
    return getY();
  }
}
