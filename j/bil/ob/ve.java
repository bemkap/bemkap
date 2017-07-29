package ob;
import java.awt.geom.Point2D;
import java.lang.Math;

public class ve extends Point2D.Double{
  public ve(double x,double y){
    super(x,y);
  }
  public ve(Point2D.Double p){
    super(p.getX(),p.getY());
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
  public static double cross(ve v,ve w){
    return v.getX()*w.getY()-v.getY()*w.getX();
  }
  public void rot(double a){
    setLocation(getX()*Math.cos(a)-getY()*Math.sin(a),
		getX()*Math.sin(a)+getY()*Math.cos(a));
  }
  public static ve rot(double a,ve v){
    ve w=new ve(v.x(),v.y());
    w.rot(a);
    return w;
  }
  public void sca(double a){
    norm();
    mul(a);
  }
  public static ve sca(double a,ve v){
    return ve.mul(a,ve.norm(v));
  }
  public double msqr(){
    return distanceSq(0,0);
  }
  public double mag(){
    return Math.sqrt(msqr());
  }
  public double angle(){
    return Math.atan2(getY(),getX());
  }
  public static ve norm(ve v){
    return ve.mul(1/v.mag(),v);
  }
  public void norm(){
    setLocation(x/mag(),y/mag());
  }
  public double x(){
    return getX();
  }
  public double y(){
    return getY();
  }
}
