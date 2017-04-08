package forms;

import control.Jtext1;
import java.sql.*;
import util.Tabla;
import db.*;

public class f_login extends javax.swing.JFrame {
  static DB db = null;
  public f_login() {
    initComponents();
  }
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents() {

    btnlogin = new javax.swing.JButton();
    txtusuario = new Jtext1(); //new javax.swing.JTextField();
    txtclave = new javax.swing.JPasswordField();

    setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
    setPreferredSize(new java.awt.Dimension(640, 480));
    setSize(new java.awt.Dimension(640, 480));

    btnlogin.setText("login");
    btnlogin.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        btnloginActionPerformed(evt);
      }
    });

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addGap(162, 162, 162)
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.CENTER)
          .addComponent(txtusuario)
          .addComponent(txtclave)
          .addComponent(btnlogin, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE))
        .addGap(169, 169, 169))
    );
    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addGap(193, 193, 193)
        .addComponent(txtusuario, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(txtclave, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(btnlogin)
        .addContainerGap(212, Short.MAX_VALUE))
    );

    pack();
  }// </editor-fold>//GEN-END:initComponents
  private void btnloginActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_btnloginActionPerformed
    try {
      ResultSet rs = db.select("usuarios").ca("cla_usu").where("nom_usu='" + txtusuario.getText() + "'").exec(db);
      if(rs.next() && rs.getString("cla_usu").equals(String.valueOf(txtclave.getPassword()))) { 
        new f_inicio(db).setVisible(true);
        this.dispose();
      }
    } catch(SQLException e) { }
  }//GEN-LAST:event_btnloginActionPerformed
  public static void main(String args[]) throws SQLException, ClassNotFoundException {
    db = new DB();
    Statement stm = db.C.createStatement();
    stm.executeUpdate("create database if not exists db1");
    db.C.setCatalog("db1");
    Tabla.crear_usuarios(db);
    Tabla.crear_actividades(db);
    Tabla.crear_empresas(db);
    Tabla.crear_empcue(db);
    Tabla.crear_empact(db);
    Tabla.crear_cuentas(db);
    Tabla.crear_clientes(db);
    Tabla.crear_proveedores(db);
    Tabla.crear_comprobantes(db);
    Tabla.crear_alicuotas(db);
    java.awt.EventQueue.invokeLater(() -> { new f_login().setVisible(true); });
  }
  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JButton btnlogin;
  private javax.swing.JPasswordField txtclave;
  private javax.swing.JTextField txtusuario;
  // End of variables declaration//GEN-END:variables
}