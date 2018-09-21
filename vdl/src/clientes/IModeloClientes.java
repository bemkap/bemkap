package clientes;

import ventas.Cliente;
import ventas.ExcepcionVentasAClientes;

public interface IModeloClientes{
	public void agregarOyenteDelCambio(IVistaClientes iVistaClientes) throws ExcepcionVentasAClientes;
	public void agregarCliente(Cliente cliente) throws ExcepcionVentasAClientes;
	public void borrarCliente(Cliente cliente) throws ExcepcionVentasAClientes;
	public void actualizarCliente(Cliente cliente) throws ExcepcionVentasAClientes;
	public Cliente obtenerCliente(String dni)	throws ExcepcionVentasAClientes;
	public Cliente[] obtenerTodosLosClientes() throws ExcepcionVentasAClientes;
}
