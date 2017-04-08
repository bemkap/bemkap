package control;

import java.awt.event.KeyEvent;
import static java.awt.event.KeyEvent.*;
import java.awt.event.KeyListener;
import javax.swing.JTextField;

public class Jtext1 extends JTextField {
  public Jtext1() { 
    super(); 
    this.addKeyListener(new KeyListener(){
      @Override
      public void keyTyped(KeyEvent ke) {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
      }
      @Override
      public void keyPressed(KeyEvent ke) {
        switch(ke.getKeyCode()) {
          case VK_F3: break;
        }
      }
      @Override
      public void keyReleased(KeyEvent ke) {
        //throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
      }
    });
  }
}
