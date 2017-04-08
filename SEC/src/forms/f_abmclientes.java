package forms;

import control.Jtext1;
import javax.swing.JInternalFrame;

public class f_abmclientes extends JInternalFrame {
  public f_abmclientes(Boolean a) {
    initComponents();
    txtcodigo.setVisible(!a);
    cmdeliminar.setVisible(!a);
    labcodigo.setVisible(!a);
    txtnombre.setEnabled(a);
    txtcuit.setEnabled(a);
  }
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents() {

    labcuit = new javax.swing.JLabel();
    txtcodigo = new javax.swing.JTextField();
    txtnombre = new javax.swing.JTextField();
    txtcuit = new javax.swing.JTextField();
    labnombre = new javax.swing.JLabel();
    labcodigo = new javax.swing.JLabel();
    cmdeliminar = new javax.swing.JButton();
    cmdregistrar = new javax.swing.JButton();

    setBorder(null);
    setPreferredSize(new java.awt.Dimension(419, 458));

    labcuit.setText("cuit");

    labnombre.setText("razón social");

    labcodigo.setText("cód.cliente");

    cmdeliminar.setText("eliminar");

    cmdregistrar.setText("registrar");

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addGap(83, 83, 83)
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addGroup(layout.createSequentialGroup()
            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
              .addComponent(labcuit, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
              .addComponent(labnombre, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, javax.swing.GroupLayout.DEFAULT_SIZE, Short.MAX_VALUE)
              .addComponent(labcodigo, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.PREFERRED_SIZE, 87, javax.swing.GroupLayout.PREFERRED_SIZE))
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
            .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING, false)
              .addComponent(txtnombre, javax.swing.GroupLayout.Alignment.LEADING, javax.swing.GroupLayout.DEFAULT_SIZE, 169, Short.MAX_VALUE)
              .addComponent(txtcuit)
              .addComponent(txtcodigo)))
          .addGroup(layout.createSequentialGroup()
            .addComponent(cmdregistrar, javax.swing.GroupLayout.PREFERRED_SIZE, 128, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.UNRELATED)
            .addComponent(cmdeliminar, javax.swing.GroupLayout.PREFERRED_SIZE, 128, javax.swing.GroupLayout.PREFERRED_SIZE)))
        .addContainerGap(70, Short.MAX_VALUE))
    );
    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addGap(158, 158, 158)
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
          .addGroup(layout.createSequentialGroup()
            .addComponent(txtnombre, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addGap(4, 4, 4)
            .addComponent(txtcuit, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
            .addComponent(txtcodigo, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE))
          .addGroup(layout.createSequentialGroup()
            .addComponent(labcodigo, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
            .addComponent(labcuit, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)
            .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
            .addComponent(labnombre, javax.swing.GroupLayout.PREFERRED_SIZE, 23, javax.swing.GroupLayout.PREFERRED_SIZE)))
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED, 165, Short.MAX_VALUE)
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.BASELINE)
          .addComponent(cmdregistrar)
          .addComponent(cmdeliminar))
        .addContainerGap())
    );

    pack();
  }// </editor-fold>//GEN-END:initComponents
  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JButton cmdeliminar;
  private javax.swing.JButton cmdregistrar;
  private javax.swing.JLabel labcodigo;
  private javax.swing.JLabel labcuit;
  private javax.swing.JLabel labnombre;
  private javax.swing.JTextField txtcodigo;
  private javax.swing.JTextField txtcuit;
  private javax.swing.JTextField txtnombre;
  // End of variables declaration//GEN-END:variables
}
