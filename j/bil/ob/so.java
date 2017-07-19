package ob;
import java.awt.*;
import ob.ba;

public class so extends ba{
  public so(double x,double y,float r,float g,float b,int n){
    super(x,y,n);
    c=new Color(r,g,b);
  }
  public so(double x,double y,int n,String fn){
    super(x,y,n,fn);
  }
}
