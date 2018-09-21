package ventas;

import java.io.Serializable;

public class Cliente implements Serializable{
    /**
	 * 
	 */
	private static final long serialVersionUID = 4388574144294342191L;
	private String dni;
    private String nombre;
    private String direccion;
    
    // Constructores
    public Cliente(String dni, String nombre, String direccion){
        this.dni = dni;
        this.nombre = nombre;
        this.direccion = direccion;
    }
    
    public Cliente(String dni){
        this(dni, null, null);
    }
    
    public Cliente(){
        this(null, null, null);
    }
    
    // Métodos de acceso
    public String getDni(){
        return dni;
    }
    
    public String getNombre(){
        return nombre;
    }
    
    public String getDireccion(){
        return direccion;
    }
    
    // Métodos de mutación. Notar que no se puede cambiar el dni
    public void setNombre(String nuevoNombre){
        nombre = nuevoNombre;
    }
    
    public void setDireccion(String nuevaDireccion){
        direccion = nuevaDireccion;
    }
    
    public String toString() {
        return "Cliente:  " + dni + "  " + nombre + "  " + direccion;
    }
}

