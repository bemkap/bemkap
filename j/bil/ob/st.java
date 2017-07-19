package ob;
import ob.ba;
import java.awt.Color;
import java.awt.LinearGradientPaint;
import java.awt.MultipleGradientPaint.CycleMethod;

public class st extends ba{
  public st(double x,double y,float r,float g,float b,int n){
    super(x,y,n);
    c=new LinearGradientPaint((float)x,(float)y-3,(float)x,(float)y+3,
			      new float[]{0f,0.5f,1f},
			      new Color[]{Color.WHITE,new Color(r,g,b),Color.WHITE},
			      CycleMethod.REPEAT);
  }
  public st(double x,double y,int n,String fn){
    super(x,y,n,fn);
  }
}
