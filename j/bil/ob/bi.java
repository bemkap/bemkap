package main;
import ob.*;
import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import javax.swing.*;
import java.lang.Math;

class sur extends JPanel implements ActionListener{
  public bs bas=new bs();
  public ta tab=new ta();
  public cu cue=new cu(100,75);
  public br pbr=new br();
  public ho hos=new ho();
  public Timer tim=new Timer(20,this);
  public pl pla=new pl();
  public double sca=2;
  public sur(){
    tim.setInitialDelay(20);
    tim.start();
  }
  public void upda(){
    cue.upda(); pbr.upda();
    switch(bas.sta){
    case ST_MOV:
      for(int i=0,j;i<bas.size();i++){
	for(j=0;j<hos.n;j++)
	  if(hos.coll(j,bas.get(i))) hos.reac(j,bas.get(i));
    	if(j==hos.n&&bas.get(i).coll(tab)) bas.get(i).reac(tab);
      }
      bas.upda();
      break;
    case ST_JST:
      bas.sta=bs.ST.ST_STO;
      if(bas.get(0).sc){
	pla.change(2);
	bas.get(0).sc=false;
	bas.get(0).setp(100,75);
      }
      else if(!hos.sosc&&!hos.stsc) pla.shoot();
      else if( pla.curr().so&& hos.sosc&&!hos.stsc) pla.curr().n=1;
      else if(!pla.curr().so&&!hos.sosc&& hos.stsc) pla.curr().n=1;
      else pla.change(2);
      pbr.cp=0;
      break;
    case ST_STO:
      cue.v=true;
      cue.setp(bas.whi.x(),bas.whi.y());
    }
  }
  @Override
  public void paintComponent(Graphics g){
    Graphics2D g1=(Graphics2D)g;
    g1.scale(sca,sca);
    super.paintComponent(g);
    tab.draw(g1); hos.draw(g1); bas.draw(g1);
    cue.draw(g1); pbr.draw(g1); pla.draw(g1);
  }
  public void actionPerformed(ActionEvent e){
    upda();
    repaint();
  }
  public void keyPressed(KeyEvent e){
    switch(e.getKeyCode()){
    case KeyEvent.VK_SPACE:
      if(bas.sta==bs.ST.ST_STO)
	switch(pbr.sta){
	case 0: pbr.first(); break;
	case 1: pbr.second(); break;
	case 2:
	  pbr.stop();
          double p=pbr.p1/100*15;
          double d=cue.d;//+pbr.p2/10;
	  bas.whi.setf(p*Math.cos(d),p*Math.sin(d));
	  cue.v=false;
	  bas.restart();
	  hos.restart();
	}
    }
  }
  public void keyReleased(KeyEvent e){}
  public void mouseMoved(MouseEvent e){
    cue.d=ve.sub(new ve(e.getX()/sca,e.getY()/sca),cue.p).angle();
  }
}

public class bi extends JFrame{
  public sur s;
  public bi(){
    setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    s=new sur();
    add(s);
    addKeyListener(new KeyAdapter(){
	@Override
	public void keyPressed(KeyEvent e){s.keyPressed(e);}
	@Override
	public void keyReleased(KeyEvent e){s.keyReleased(e);}
      });
    addMouseMotionListener(new MouseMotionAdapter(){
	@Override
	public void mouseMoved(MouseEvent e){s.mouseMoved(e);}
      });
  }
  public static void main(String[]args){
    EventQueue.invokeLater(new Runnable(){
	@Override
	public void run(){
	  bi b=new bi();
	  b.setVisible(true);
	}
      });
  }
}
