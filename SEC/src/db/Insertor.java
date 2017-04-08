package db;

import java.sql.*;
import java.util.Collections;

public class Insertor {
  String tabla;
  PreparedStatement pstm;
  Integer i;
  public Insertor ca(DB db, String...cs) throws SQLException {
    String sql_str = "insert ignore into " + tabla + "(" + String.join(",", cs) + ") values (" +
            String.join(",", Collections.nCopies(cs.length, "?")) + ")";
    pstm = db.C.prepareCall(sql_str);
    i = 1;
    return this;
  }
  public Insertor v_int(Integer v) throws SQLException { pstm.setInt(i++, v); return this; }
  public Insertor v_tinyint(Byte v) throws SQLException { pstm.setByte(i++, v); return this; }
  public Insertor v_double(Double v) throws SQLException { pstm.setDouble(i++, v); return this; }
  public Insertor v_varchar(String v) throws SQLException { pstm.setString(i++, v); return this; }
  public Insertor v_boolean(Boolean v) throws SQLException { pstm.setBoolean(i++, v); return this; }
  public void exec(DB db) throws SQLException { pstm.executeUpdate(); }
}
