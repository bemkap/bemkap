package main;
import ob.*;
import java.applet.Applet;
import java.awt.*;
import java.awt.event.*;
import java.awt.geom.*;
import javax.swing.*;

class sur extends JPanel implements ActionListener{
  public final int FPS=50;
  public final double sca=2;
  public Timer tim=new Timer(1000/FPS,this);
  public gs gst[]={new ms(),new na(),new ga(),new es()};
  public int cst=0;
  public int[][] fsm={{0,1,2,3},{1,2,3,0}};
  public sur(){
    tim.setInitialDelay(1000/FPS);
    tim.start();
    addMouseMotionListener(new MouseMotionAdapter(){
	@Override
	public void mouseMoved(MouseEvent e){
	  cst=fsm[gst[cst].mouse(e,sca,10,10)][cst];
	}
      });
  }
  @Override
  public void paintComponent(Graphics g){
    super.paintComponent(g);
    Graphics2D g1=(Graphics2D)g;
    g1.scale(sca,sca);
    g1.translate(10,10);
    gst[cst].paint(g1,sca,10,10);
  }
  public void actionPerformed(ActionEvent e){
    cst=fsm[gst[cst].upda()][cst];
    repaint();
  }
  public void keyPressed(KeyEvent e){
    cst=fsm[gst[cst].key(e)][cst];
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
