package ventas;

import java.io.Serializable;
import java.util.*;

public class Cartera implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 9035943531898459103L;
	private Cliente cliente;
    private ArrayList<Libro> libros;
    
    public Cartera(Cliente cliente, ArrayList<Libro> libros) {
        this.cliente = cliente;
        this.libros = libros;
    }
    
    public Cartera(Cliente cliente) {
        this.cliente = cliente;
        this.libros = new ArrayList<Libro>(10);
    }
    
    // métodos de acceso
    public Cliente getCliente(){
        return cliente;
    }
    
    public Libro[] getLibros(){
        Libro[] vecLibros = new Libro[libros.size()];
        vecLibros = libros.toArray(vecLibros);
        return vecLibros;
    }

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((cliente == null) ? 0 : cliente.hashCode());
		result = prime * result + ((libros == null) ? 0 : libros.hashCode());
		return result;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Cartera other = (Cartera) obj;
		if (cliente == null) {
			if (other.cliente != null)
				return false;
		} else if (!cliente.equals(other.cliente))
			return false;
		if (libros == null) {
			if (other.libros != null)
				return false;
		} else if (!libros.equals(other.libros))
			return false;
		return true;
	}
    
    // otros métodos que se podrían colocar en la clase 
	// pero que no deberían estar
    // public void agregarLibro(Libro libro){}  
    // public void quitarLibro(Libro libro){} 
    // public double getPrecio() {}  
}