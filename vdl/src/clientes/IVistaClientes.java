package clientes;

import ventas.Cliente;
import ventas.ExcepcionVentasAClientes;

public interface IVistaClientes{
    void agregarOyenteAccionUsuario(IControladorClientes con)	throws ExcepcionVentasAClientes;
    void mostrarEnPantalla(Object objAMostrar) throws ExcepcionVentasAClientes;
    void manejarCambioEnElModeloDelCliente(Cliente cliente)	throws ExcepcionVentasAClientes;
}