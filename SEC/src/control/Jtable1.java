package control;

import db.DB;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class Jtable1 extends JTable {
  public void llenar(DB db, String ta, String...cs) throws SQLException {
    ResultSet rc = db.select(ta).ca("count(*)").exec(db);
    if(rc.next()) {
      DefaultTableModel tm = new DefaultTableModel(cs, rc.getInt(1));
      ResultSet rs = db.select(ta).ca(cs).exec(db);
      for(Integer i = 0; rs.next(); i++)
        for(Integer j = 0; j < cs.length; j++)
          tm.setValueAt(rs.getObject(j + 1).toString(), i, j);
      setModel(tm);
    }
  }
}