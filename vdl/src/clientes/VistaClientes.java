package clientes;

import java.awt.BorderLayout;
import java.awt.GridLayout;
import javax.swing.*;
import javax.swing.table.DefaultTableModel;
import ventas.Cliente;
import ventas.ExcepcionVentasAClientes;

public class VistaClientes extends JFrame implements IVistaClientes{
  private static final long serialVersionUID=-5098108790051128201L;
  JTabbedPane tabs;
  JPanel panDetalles,panTodos,panRegistro;
  JLabel labNombre,labDni,labDireccion,labTodos;
  JTextField txtNombre,txtDni,txtDireccion;
  JTable tabTodos;
  JTextArea txtRegistro;
  JButton btnObtener,btnActualizar,btnAgregar,btnBorrar;
  public VistaClientes(String t){
    super(t);
    setLayout(new BoxLayout(getContentPane(),BoxLayout.PAGE_AXIS));
    setSize(300,300);
    tabs=new JTabbedPane();
    panDetalles=new JPanel(new GridLayout(5,2));
    panTodos=new JPanel(new BorderLayout());
    panRegistro=new JPanel(new BorderLayout());
    labNombre=new JLabel("Nombre del cliente");
    labDni=new JLabel("DNI del cliente");
    labDireccion=new JLabel("Direccion del cliente");
    labTodos=new JLabel("Todos los clientes");
    txtNombre=new JTextField();
    txtDni=new JTextField();
    txtDireccion=new JTextField();
    tabTodos=new JTable(new DefaultTableModel(1,3));
    txtRegistro=new JTextArea();
    btnObtener=new JButton("Obtener cliente");
    btnActualizar=new JButton("Actualizar cliente");
    btnAgregar=new JButton("Agregar cliente");
    btnBorrar=new JButton("Borrar cliente");
    panDetalles.add(labNombre); panDetalles.add(txtNombre);
    panDetalles.add(labDni); panDetalles.add(txtDni);
    panDetalles.add(labDireccion); panDetalles.add(txtDireccion);
    panDetalles.add(btnObtener); panDetalles.add(btnActualizar);
    panDetalles.add(btnAgregar); panDetalles.add(btnBorrar);
    panTodos.add(labTodos,BorderLayout.NORTH);
    panTodos.add(tabTodos,BorderLayout.CENTER);
    panRegistro.add(txtRegistro);
    tabs.add("Detalles",panDetalles);
    tabs.add("Todos",panTodos);
    add(tabs);
    add(panRegistro);
  }
  @Override
  public void agregarOyenteAccionUsuario(IControladorClientes con) throws ExcepcionVentasAClientes{
    // TODO Auto-generated method stub
    
  }
  @Override
  public void mostrarEnPantalla(Object objAMostrar) throws ExcepcionVentasAClientes{
    // TODO Auto-generated method stub
    
  }
  @Override
  public void manejarCambioEnElModeloDelCliente(Cliente cliente) throws ExcepcionVentasAClientes{
    // TODO Auto-generated method stub
    
  }
}
