package ventas;

import java.io.Serializable;

public class Inventario implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = -8283344344307922991L;
	private String isbn;
    private float precio;
    
    public Inventario(String isbn, float precio){
        this.isbn = isbn;
        this.precio = precio;
    }
    
    public float getPrecio() {
        return precio;
    }
    
    public String getIsbn() {
        return isbn;
    }
    
    public void setPrecio(float newPrice) {
        precio = newPrice;
    }
    
    public String toString() {
        return "Inventario:  " + isbn + "  " + precio;
    }
}