package ventas;


public class ExcepcionVentasAClientes extends Exception{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8100846565697439534L;

	/**
     * Crea un nuevo objeto del tipo <code>ExcepcionVentasAClientes</code> con el mensaje de detalle de error.
     */
    public ExcepcionVentasAClientes() {
        this("ExcepcionVentasAClientes");
    }
    
    /**
     * Construye una <code>ExcepcionVentasAClientes</code> con el mensaje del detalle
     * especificado como parámetro
     * @param mensaje	Texto que detalla el error.
     */
    public ExcepcionVentasAClientes(String mensaje) {
        super(mensaje);
    }
}
