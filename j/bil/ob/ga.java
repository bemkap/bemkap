package ob;
import ob.*;
import java.awt.event.KeyEvent;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;

public class ga implements gs{
  public bs bas=new bs();
  public ta tab=new ta();
  public cu cue=new cu(100,75);
  public br pbr=new br();
  public ho hos=new ho(tab.w,tab.h);
  public pl pla=new pl();
  public bw bwh=new bw(300,10);
  public int upda(){
    pbr.upda();
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
      bas.sta=bs.ST.ST_STO;
      if(hos.sosc||hos.stsc){
	if(bas.get(0).sc){
	  if(pla.so()==null) pla.setso(hos.sosc);
	  pla.change(2);
	}else if(bas.get(1).sc){
	  // if(bas.left(pla.so())<=0) win();
	  // else loose();
	}else if(pla.so()!=null){
	  if(pla.so()==bas.fso&&pla.so()==hos.sosc) pla.setn(1);
	  else pla.change(2);
	}else{
	  pla.setso(hos.sosc);
	  pla.setn(1);
	}
      }else{
	if(bas.fso!=null){
	  if(pla.so()!=null){
	    if(bas.fso==pla.so()) pla.shoot();
	    else pla.change(2);
	  }else pla.shoot();
	}else pla.change(2);
      }
      pbr.cp=0;
      hos.sosc=false;
      hos.stsc=false;
      bas.fso=null;
      break;
    case ST_STO:
      cue.v=true;
      cue.setLocation(bas.whi.x(),bas.whi.y());
    }
    return 0;
  }
  public void paint(Graphics2D g,double sca,int ox,int oy){
    Graphics2D f=(Graphics2D)g.create();
    f.translate(ox,oy);
    tab.draw(f); hos.draw(f); bas.draw(f);
    cue.draw(f); pbr.draw(f); pla.draw(f);
    bwh.draw(f);
    f.dispose();
  }
  public int key(KeyEvent e){
    bwh.key(e);
    switch(e.getKeyCode()){
    case KeyEvent.VK_SPACE:
      if(bas.sta==bs.ST.ST_STO)
	if(!pbr.pushed()) pbr.first();
	else{
	  pbr.stop();
          double p=(10*0.5/10)*pbr.cp/100*30;
	  bas.whi.f.setLocation(p*Math.cos(cue.d),p*Math.sin(cue.d));
	  bas.whi.af=ve.mul(5/2*10/ba.r/ba.r,bwh.w);
	  cue.v=false;
	  bas.fso=null;
	  bas.sta=bs.ST.ST_MOV;
	  hos.sosc=false;
	  hos.stsc=false;
	}
    }
    return 0;
  }
  public int mouse(MouseEvent e,double sca,int ox,int oy){
    cue.d=ve.sub(new ve(e.getX()/sca-ox,e.getY()/sca-oy),cue).angle();
    return 0;
  }
}
