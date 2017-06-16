package ob;
import ob.*;
import java.awt.Graphics2D;
import java.awt.Font;
import java.awt.Color;

public class pl implements dr{
  public class p{
    public int n=1;
    public boolean so;
    public p(boolean s){
      so=s;
    }
  }
  public p[] ps=new p[2];
  public int cp=0;
  public pl(){
    ps[0]=new p(true);
    ps[1]=new p(false);
  }
  public void change(int nn){
    cp=(cp+1)%2;
    ps[cp].n=nn;
  }
  public void shoot(){
    if(--ps[cp].n<=0) change(1);
  }
  public p curr(){return ps[cp];}
  public void draw(Graphics2D g){
    g.setFont(new Font("Monospaced",Font.PLAIN,8));
    g.setPaint(new Color(0,0,0));
    g.drawString("pl1",10,190);
    g.drawString("pl2",10,200);
    g.drawString("<<<",30,190+cp*10);
    g.drawString("tiros "+ps[cp].n,60,195);
  }
}
