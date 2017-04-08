package db;

import java.sql.*;

public class DB {
  public Connection C = null;
  Creador cr = new Creador();
  Insertor in = new Insertor();
  Selector se = new Selector();
  public DB() throws SQLException, ClassNotFoundException {
    Class.forName("com.mysql.jdbc.Driver");
    C = DriverManager.getConnection("jdbc:mysql://localhost/", "root", "root");
  }
  public void close() throws SQLException {
    if(C != null) C.close();
  }
  public Creador create(String tabla) { cr.tabla = tabla; return cr; }
  public Insertor insert(String tabla) { in.tabla = tabla; return in; }
  public Selector select(String tabla) { se.tabla = tabla; return se; }
}
