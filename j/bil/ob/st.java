package ob;
import ob.ba;
import java.awt.Color;
import java.awt.GradientPaint;

public class st extends ba{
  public st(double x,double y,float r,float g,float b,int n){
    super(x,y,n);
    c=new GradientPaint((float)x-7,(float)y,Color.black,
			(float)x,(float)y,new Color(r,g,b),true);
  }
}
