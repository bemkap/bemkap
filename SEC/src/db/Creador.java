package db;

import java.sql.*;
import java.util.ArrayList;

public class Creador {
  String tabla;
  ArrayList<String> campos = new ArrayList();
  ArrayList<String> ex = new ArrayList();
  public Creador c_cod(String n) { campos.add(n + " integer auto_increment primary key"); return this; }
  public Creador c_int(String n) { campos.add(n + " integer"); return this; }
  public Creador c_tinyint(String n) { campos.add(n + " tinyint"); return this; }
  public Creador c_bigint(String n) { campos.add(n + " bigint"); return this; }
  public Creador c_double(String n) { campos.add(n + " double"); return this; }
  public Creador c_varchar(String n, Integer l) { campos.add(n + " varchar(" + l + ")"); return this; }
  public Creador c_boolean(String n) { campos.add(n + " boolean"); return this; }
  public Creador c_date(String n) { campos.add(n + " date"); return this; }
  public Creador primaries(String k1, String k2) { ex.add("primary key(" + k1 + "," + k2 + ")"); return this; }
  public Creador reference(String f, String t) { ex.add("foreign key(" + f + ") references " + t + "(" + f + ")"); return this; }
  public void exec(DB db) throws SQLException {
    Statement stm = db.C.createStatement();
    String sql_str = "create table if not exists " + tabla + "(" +
                     String.join(",", campos) + (ex.size() > 0 ? "," : "") +
                     String.join(",", ex) + ")";
    stm.executeUpdate(sql_str);
    campos.clear();
    ex.clear();
  }
}
