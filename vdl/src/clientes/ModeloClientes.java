package clientes;

import java.util.ArrayList;
import java.util.HashMap;
import ventas.Cliente;
import ventas.ExcepcionVentasAClientes;

public class ModeloClientes implements IModeloClientes{
  HashMap<String,Cliente>clientes=new HashMap<>();
  ArrayList<IVistaClientes>oyentes=new ArrayList<>();
  @Override
  public void agregarOyenteDelCambio(IVistaClientes iVistaClientes) throws ExcepcionVentasAClientes{
    oyentes.add(iVistaClientes);
  }
  @Override
  public void agregarCliente(Cliente cliente) throws ExcepcionVentasAClientes{
    clientes.put(cliente.getDni(),cliente);
  }
  @Override
  public void borrarCliente(Cliente cliente) throws ExcepcionVentasAClientes{
    clientes.remove(cliente.getDni());    
  }
  @Override
  public void actualizarCliente(Cliente cliente) throws ExcepcionVentasAClientes{
    borrarCliente(cliente);
    agregarCliente(cliente);
  }
  @Override
  public Cliente obtenerCliente(String dni) throws ExcepcionVentasAClientes{
    return clientes.get(dni);
  }
  @Override
  public Cliente[] obtenerTodosLosClientes() throws ExcepcionVentasAClientes{
    return (Cliente[])clientes.values().toArray();
  }
}
