package clientes;

import ventas.Cliente;

public interface IControladorClientes {
    void manejadorAccionObtenerCliente(String id);
    void manejadorAccionAgregarCliente(Cliente c);
    void manejadorAccionBorrarCliente(Cliente c);
    void manejadorAccionAcualizarCliente(Cliente c);
    void manejadorAccionObtenesTodosLosClientes();
}