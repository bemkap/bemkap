package db;

import java.util.ArrayList;
import java.sql.*;
import java.util.Collections;

public class Selector {
  String tabla, cond;
  ArrayList<String> cs = new ArrayList();
  public Selector ca(String...cs) { Collections.addAll(this.cs, cs); return this; }
  public Selector where(String c) { cond = c; return this; }
  public ResultSet exec(DB db) throws SQLException {
    String sql_str = "select " + String.join(",", cs) + " from " + tabla + 
            (cond.equals("") ? "" : " where " + cond);
    System.out.println(sql_str);
    cond = ""; cs.clear();
    return db.C.createStatement().executeQuery(sql_str);
  }
}
