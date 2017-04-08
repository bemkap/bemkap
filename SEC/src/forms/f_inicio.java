package forms;

import db.DB;
import java.beans.PropertyVetoException;
import javax.swing.JInternalFrame;
import javax.swing.event.TreeSelectionEvent;
import javax.swing.tree.DefaultMutableTreeNode;
import javax.swing.tree.DefaultTreeModel;

public class f_inicio extends javax.swing.JFrame {
  JInternalFrame actu = null;
  static DB db = null;
  public f_inicio(DB db) {
    initComponents();
    this.db = db;
    Integer j = 0;
    VTreeNode root = new VTreeNode("root", j++);
    String[] c0 = {"altas", "bajas-mods", "consultas", "listados", "totales"};
    String[] c1 = {"actividades", "clientes", "compras-gastos", "cuentas", "empresas", "proveedores", "usuarios", "ventas-cobros"};
    String[] c2 = {"clientes", "empresas", "proveedores", "combustible"};
    String[] c3 = {"iva compras", "iva ventas", "ing. brutos"};
    VTreeNode[] cn0 = new VTreeNode[5];
    for(Integer i = 0; i < 5; i++) root.add((cn0[i] = new VTreeNode(c0[i], j++)));
    for(String c : c1) cn0[0].add(new VTreeNode(c, j++));
    for(String c : c1) cn0[1].add(new VTreeNode(c, j++));
    for(String c : c2) cn0[1].add(new VTreeNode(c, j++));
    for(String c : c3) cn0[2].add(new VTreeNode(c, j++));
    trmodulos.setModel(new DefaultTreeModel(root));
    trmodulos.setRootVisible(false);
    trmodulos.addTreeSelectionListener((TreeSelectionEvent tse) -> {
            Integer idx = ((VTreeNode)tse.getPath().getLastPathComponent()).getTag();
            if(idx > 5) {
              if(actu != null) actu.dispose();
              switch(idx) {
                case  6: case 14: actu = new f_abmactividades(db); break;
                case  7: case 15: actu = new f_abmclientes(idx == 7); break;
                case 11: case 19: actu = new f_abmproveedores(idx == 11); break;
              }
              actu.setVisible(true);
              pane.add(actu);
              try { actu.setMaximum(true); } catch(PropertyVetoException e) { }
            }
    });
  }
  @SuppressWarnings("unchecked")
  // <editor-fold defaultstate="collapsed" desc="Generated Code">//GEN-BEGIN:initComponents
  private void initComponents() {

    jFrame1 = new javax.swing.JFrame();
    jScrollPane1 = new javax.swing.JScrollPane();
    trmodulos = new javax.swing.JTree();
    pane = new javax.swing.JDesktopPane();

    javax.swing.GroupLayout jFrame1Layout = new javax.swing.GroupLayout(jFrame1.getContentPane());
    jFrame1.getContentPane().setLayout(jFrame1Layout);
    jFrame1Layout.setHorizontalGroup(
      jFrame1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGap(0, 400, Short.MAX_VALUE)
    );
    jFrame1Layout.setVerticalGroup(
      jFrame1Layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGap(0, 300, Short.MAX_VALUE)
    );

    setDefaultCloseOperation(javax.swing.WindowConstants.EXIT_ON_CLOSE);
    setPreferredSize(new java.awt.Dimension(640, 480));
    setSize(new java.awt.Dimension(640, 480));

    javax.swing.tree.DefaultMutableTreeNode treeNode1 = new javax.swing.tree.DefaultMutableTreeNode("root");
    trmodulos.setModel(new javax.swing.tree.DefaultTreeModel(treeNode1));
    jScrollPane1.setViewportView(trmodulos);

    javax.swing.GroupLayout paneLayout = new javax.swing.GroupLayout(pane);
    pane.setLayout(paneLayout);
    paneLayout.setHorizontalGroup(
      paneLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGap(0, 419, Short.MAX_VALUE)
    );
    paneLayout.setVerticalGroup(
      paneLayout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGap(0, 0, Short.MAX_VALUE)
    );

    javax.swing.GroupLayout layout = new javax.swing.GroupLayout(getContentPane());
    getContentPane().setLayout(layout);
    layout.setHorizontalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(layout.createSequentialGroup()
        .addContainerGap()
        .addComponent(jScrollPane1, javax.swing.GroupLayout.PREFERRED_SIZE, 195, javax.swing.GroupLayout.PREFERRED_SIZE)
        .addPreferredGap(javax.swing.LayoutStyle.ComponentPlacement.RELATED)
        .addComponent(pane)
        .addContainerGap())
    );
    layout.setVerticalGroup(
      layout.createParallelGroup(javax.swing.GroupLayout.Alignment.LEADING)
      .addGroup(javax.swing.GroupLayout.Alignment.TRAILING, layout.createSequentialGroup()
        .addContainerGap()
        .addGroup(layout.createParallelGroup(javax.swing.GroupLayout.Alignment.TRAILING)
          .addComponent(pane)
          .addComponent(jScrollPane1, javax.swing.GroupLayout.DEFAULT_SIZE, 458, Short.MAX_VALUE))
        .addContainerGap())
    );

    pack();
  }// </editor-fold>//GEN-END:initComponents
  public static void main(String args[]) {
    java.awt.EventQueue.invokeLater(() -> { new f_inicio(db).setVisible(true); });
  }
  // Variables declaration - do not modify//GEN-BEGIN:variables
  private javax.swing.JFrame jFrame1;
  private javax.swing.JScrollPane jScrollPane1;
  private javax.swing.JDesktopPane pane;
  private javax.swing.JTree trmodulos;
  // End of variables declaration//GEN-END:variables
}

class VTreeNode extends DefaultMutableTreeNode {
  private final Integer tag;
  public VTreeNode(String n, Integer v) { super(n); tag = v; }
  public Integer getTag() { return tag; }
}