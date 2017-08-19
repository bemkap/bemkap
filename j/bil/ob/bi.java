package main;
import ob.*;
import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import javax.swing.*;
import javax.swing.event.*;

class sur extends JPanel implements ActionListener{
  public final int FPS=50;
  public final double sca=2;
  public final int ofx=150,ofy=25;
  public Timer tim=new Timer(1000/FPS,this);
  public gs gst[]={new ms(),new ga(),new es()};
  public int cst=0;
  public int[][] fsm={{0,1,2},{1,2,0},{0,2,2}};
  public sur(){
    tim.setInitialDelay(1000/FPS);
    tim.start();
    addMouseMotionListener(new MouseMotionAdapter(){
	@Override
	public void mouseMoved(MouseEvent e){
	  cst=fsm[gst[cst].mouseMoved(e,sca,ofx,ofy)][cst];
	}
      });
    addMouseListener(new MouseAdapter(){
	@Override
	public void mousePressed(MouseEvent e){
	  cst=fsm[gst[cst].mouseClicked(e,sca,ofx,ofy)][cst];
	}
      });
  }
  @Override
  public void paintComponent(Graphics g){
    super.paintComponent(g);
    Graphics2D g1=(Graphics2D)g;
    g1.scale(sca,sca);
    g1.translate(ofx,ofy);
    gst[cst].paint(g1);
  }
  public void actionPerformed(ActionEvent e){
    cst=fsm[gst[cst].upda()][cst];
    repaint();
  }
  public void keyPressed(KeyEvent e){
    cst=fsm[gst[cst].keyPressed(e)][cst];
  }
  public void keyReleased(KeyEvent e){
    cst=fsm[gst[cst].keyReleased(e)][cst];
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
