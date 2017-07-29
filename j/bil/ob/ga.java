package ob;
import ob.*;
import java.awt.event.KeyEvent;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;

public class ga extends ag{
  public bs bas=new bs();
  public ta tab=new ta();
  public cu cue=new cu(0,0);
  public ho hos=new ho(tab.w,tab.h);
  public pl pla=new pl();
  public int upda(){
    switch(bas.sta){
    case ST_MOV:
      bas.upda();
      for(int i=0;i<bas.size();i++){
	tab.reac(tab.coll(bas.get(i)),bas.get(i));
	for(int j=0;j<6;j++)
	  if(hos.coll(j,bas.get(i))){
	    hos.reac(j,bas.get(i));
	    break;
	  }
      }
      break;
    case ST_JST:
      cue.spi=0;
      bas.sta=bs.ST.ST_STO;
      int b0=(hos.sosc||hos.stsc)?1:0;
      int b1=(bas.whi.sc)?2:0;
      int b2=(pla.so()==null)?4:0;
      int b3=(bas.bla.sc)?8:0;
      int b4=(pla.so()==bas.fso)?16:0;
      int b5=(b2==0&&pla.so()==hos.sosc)?32:0;
      int b6=(bas.fso!=null)?64:0;
      if(b1>0){bas.whi.setLocation(66.5,66.5); bas.whi.sc=false;}
      switch(b0+b2+b3+b4+b5+b6){
      case  5: pla.setso(hos.sosc); pla.setn(1); break;
      case  7: pla.setso(hos.sosc); break;
      case  9: return 1;
      case 49: pla.setn(1); break;
      case 68: case 80: pla.shoot(); break;
      default: pla.change(2);
      }
      hos.sosc=false;
      hos.stsc=false;
      bas.fso=null;
      break;
    case ST_STO:
      cue.upda();
      cue.setLocation(bas.whi);
      cue.v=true;
      if(cue.coll(bas.whi)){
	cue.reac(bas.whi);
	bas.whi.W=-cue.spi/ba.r*Math.PI/60;
	bas.fso=null;
	bas.sta=bs.ST.ST_MOV;
	hos.sosc=false;
	hos.stsc=false;
      }
    }
    return 0;
  }
  public void paint(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    tab.draw(f); hos.draw(f); cue.draw(f);
    bas.draw(f); pla.draw(f,bas);
    f.dispose();
  }
  public int keyPressed(KeyEvent e){
    return cue.keyPressed(e);
  }
  public int keyReleased(KeyEvent e){
    return cue.keyReleased(e);
  }
  public int mouseMoved(MouseEvent e,double sca,int ox,int oy){
    return cue.mouseMoved(e,sca,ox,oy);
  }
}
