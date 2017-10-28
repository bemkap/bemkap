package ob;
import ob.*;
import java.awt.event.KeyEvent;
import java.awt.event.ActionEvent;
import java.awt.Graphics2D;
import java.awt.event.MouseEvent;
import java.awt.Font;

public class ms extends ag{
  public ta tab=new ta();
  public void paint(Graphics2D g){
    Graphics2D f=(Graphics2D)g.create();
    tab.draw(f);
    f.setFont(new Font("Monospaced",Font.PLAIN,32));
    f.drawString("PUL",107,70);
    f.setFont(new Font("Monospaced",Font.PLAIN,8));
    f.drawString("any key to start",96,90);
    f.dispose();
  }
  public int keyPressed(KeyEvent e){
    return 1;
  }
}
