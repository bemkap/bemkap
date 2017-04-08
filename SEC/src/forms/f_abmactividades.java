package forms;

import control.Jtable1;
import db.DB;
import db.Insertor;
import java.io.IOException;
import java.nio.charset.Charset;
import java.nio.file.*;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;

public class f_abmactividades extends JInternalFrame {
  DefaultTableModel tm;
  DB db;
  public f_abmactividades(DB db) {
    initComponents();
    this.db = db;
    tm = new DefaultTableModel();
    tm.setColumnIdentifiers(new String[]{"cod_act", "nom_act", "obs_act"});
    lstactividades.setModel(tm);
  }
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents() {

    cmdarchivo = new javax.swing.JButton();
    cmdregistrar = new javax.swing.JButton();
    txtarchivo = new javax.swing.JTextField();
    jScrollPane2 = new javax.swing.JScrollPane();
    lstactividades = new Jtable1();

    setBorder(null);
    setPreferredSize(new java.awt.Dimension(419, 458));

    cmdarchivo.setText("archivo");
    cmdarchivo.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        cmdarchivoActionPerformed(evt);
      }
    });

    cmdregistrar.setText("registrar");
    cmdregistrar.addActionListener(new java.awt.event.ActionListener() {
      public void actionPerformed(java.awt.event.ActionEvent evt) {
        cmdregistrarActionPerformed(evt);
      }
    });

    lstactividades.setModel(new javax.swing.table.DefaultTableModel(
      new Object [][] {
        {},
        {},
        {},
        {}
      },
      new String [] {

      }
    ));
    jScrollPane2.setViewportView(lstactividades);

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addGap(80, 80, 80)
        .addComponent(cmdregistrar, javax.swing.GroupLayout.PREFERRED_SIZE, 128, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(cmdarchivo, javax.swing.GroupLayout.PREFERRED_SIZE, 128, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addGap(0, 77, Short.MAX_VALUE))
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addComponent(jScrollPane2, javax.swing.GroupLayout.PREFERRED_SIZE, 0, Short.MAX_VALUE)
          .addComponent(txtarchivo))
        .addContainerGap())
    );
    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addComponent(txtarchivo, javax.swing.GroupLayout.PREFERRED_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(jScrollPane2, javax.swing.GroupLayout.DEFAULT_SIZE, 363, Short.MAX_VALUE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
          .addComponent(cmdregistrar)
          .addComponent(cmdarchivo))
        .addContainerGap())
    );

    pack();
  }// </editor-fold>//GEN-END:initComponents
  private void cmdarchivoActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdarchivoActionPerformed
    JFileChooser fc = new JFileChooser();
    fc.showOpenDialog(this);
    try {
      Path fp = fc.getSelectedFile().toPath();
      txtarchivo.setText(fp.toString());
      Files.lines(fp, Charset.forName("ISO-8859-1")).forEach((t) -> {
        tm.addRow(t.split("@"));
      }); 
    } catch(IOException ex) { }
  }//GEN-LAST:event_cmdarchivoActionPerformed

  private void cmdregistrarActionPerformed(java.awt.event.ActionEvent evt) {//GEN-FIRST:event_cmdregistrarActionPerformed
    try {
      Insertor in = db.insert("actividades").ca(db, "cod_act", "nom_act", "obs_act");
      for(Integer i = 0; i < tm.getRowCount(); i++)
        in.v_int((Integer)tm.getValueAt(i, 0)).
           v_varchar(tm.getValueAt(i, 1).toString()).
           v_varchar(tm.getValueAt(i, 2).toString()).
           exec(db);
      } catch (SQLException ex) { }
  }//GEN-LAST:event_cmdregistrarActionPerformed

  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JButton cmdarchivo;
  private javax.swing.JButton cmdregistrar;
  private javax.swing.JScrollPane jScrollPane2;
  private javax.swing.JTable lstactividades;
  private javax.swing.JTextField txtarchivo;
  // End of variables declaration//GEN-END:variables
}
