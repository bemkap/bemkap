package ob;
import ob.*;
import java.awt.Graphics2D;
import java.awt.Font;
import java.io.IOException;
import javax.imageio.ImageIO;
import java.net.*;
import java.awt.image.BufferedImage;
import java.util.ArrayList;

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
  public void setso(boolean s){
    so[cp]=s;
    so[(cp+1)%2]=!s;
  }
  public void setn(int m){n[cp]=m;}
  public void draw(Graphics2D g,bs bas){
    Graphics2D f=(Graphics2D)g.create();
    f.setFont(new Font("Monospaced",Font.PLAIN,8));
    f.drawString(new String(new char[n[cp]]).replace("\0","*"),90+cp*135,170);
    for(int i=0;i<2;i++){
      f.drawImage(impl,null,35+i*135,164);
      f.drawString(String.format("pl%d",i),64+i*135,170);
      f.drawString("color:"+(so[i]==null?"null":(so[i]?"stripes":"solid")),64+i*135,178);
      f.drawString("in   :",64+i*135,186);
      if(so[i]!=null){
	ArrayList<Integer>s=bas.scored(so[i]);
	f.drawString(s.toString()+" ("+s.size()+")",93+i*135,186);
      }
    }
    f.dispose();
  }
}
