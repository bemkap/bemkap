package ob;
import java.awt.event.KeyEvent;
import java.awt.event.ActionEvent;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;

public interface gs{
  int upda();
  void paint(Graphics2D g,double sca,int ox,int oy);
  int key(KeyEvent e);
  int mouse(MouseEvent e,double sca,int ox,int oy);
}
