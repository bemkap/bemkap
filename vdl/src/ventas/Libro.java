package ventas;

import java.io.Serializable;

public class Libro implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 3224959336040822606L;
	private Inventario inventario;
    private int cantidad;
    
    public Libro(Inventario inventario, int cantidad){
        this.inventario = inventario;
        this.cantidad = cantidad;
    }
    
    public Libro(Inventario inventario) {
        this(inventario, 0);
    }
    
    // métodos
    public double calcularValor(){
        return cantidad * inventario.getPrecio();
    }
    
    public int hashCode() {
        return inventario.getIsbn().hashCode();
    }
    
    public boolean equals(Object anObject) {
        Libro sr = (Libro) anObject;
        return sr.inventario.getIsbn().equals(this.inventario.getIsbn())
        && sr.cantidad == this.cantidad;
    }
    
    // Métodos de acceso
    public Inventario getInventario() {
        return inventario;
    }
    
    public int getCantidad() {
        return cantidad;
    }
 
    // Métodos de mutación
    public void setInventario(Inventario nuevoInventario) {
        inventario = nuevoInventario;
    }
    
    public void setCantidad(int nuevaCantidad) {
        cantidad = nuevaCantidad;
    }
    
    public String toString() {
        return "Libro:  " + inventario.getIsbn() + "  " + cantidad;
    }
}