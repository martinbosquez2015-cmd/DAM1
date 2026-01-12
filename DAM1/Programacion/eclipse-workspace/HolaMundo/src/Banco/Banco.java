package Banco;
import java.util.*;
public class Banco {
	private String nombre;
	private String codigo;
	
	private static ArrayList<Sucursal> sucursales= new ArrayList<>();
	
	public Banco(String nombre, String código) {
		this.nombre= nombre;
		//como pendiente valida el código de banco
		this.codigo=codigo;
	}
	
	public void addSuc(Sucursal s){
		sucursales.add(s);
	}
	public void listarSucursales() {
		for(Sucursal s:sucursales) {
			s.mostrar();
		}
	}
}
