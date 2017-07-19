package ob;
import ob.*;
import java.awt.Graphics2D;
import java.awt.Font;
import java.awt.Color;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.net.*;
import java.awt.image.BufferedImage;

public class pl{
  public int[]n={1,1};
  public Boolean[]so={null,null};
  public int cp=0;
  public BufferedImage impl,imcu;
  public pl(){
    URL u=null,v=null;
    try{
      u=new URL("file","","img/p.png");
      v=new URL("file","","img/c.png");
    }catch(MalformedURLException e){}
    try{
      impl=ImageIO.read(u);
      imcu=ImageIO.read(v);
    }catch(IOException e){}
  }
  public void change(int m){
    cp=(cp+1)%2;
    n[cp]=m;
  }
  public void shoot(){
    if(--n[cp]<=0) change(1);
  }
  public Boolean so(){return so[cp];}
  public int n(){return n[cp];}
  public void setso(boolean s){
    so[cp]=s;
    so[(cp+1)%2]=!s;
  }
  public void setn(int m){n[cp]=m;}
  public void draw(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    f.setFont(new Font("Monospaced",Font.PLAIN,8));
    f.drawString("1",74,182);
    if(so[0]!=null) f.drawString(so[0]?"solid":"stripes",81,182);
    f.drawString("2",209,182);
    if(so[1]!=null) f.drawString(so[1]?"solid":"stripes",216,182);
    f.drawImage(impl,null,65,185);
    f.drawImage(impl,null,200,185);
    for(int i=0;i<n[cp];i++)
      f.drawImage(imcu,null,65+cp*135+i*12,210);
    f.dispose();
  }
}
