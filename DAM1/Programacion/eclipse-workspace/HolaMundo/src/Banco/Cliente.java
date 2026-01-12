package Banco;

import java.util.ArrayList;

public class Cliente {
	private String nombre;
	private String apellidos;
	private String nie;
	private int telefono;
	private Sucursal sucursal;
	private ArrayList<CuentasCorrientes> cuentas= new ArrayList<>();
	
	
	
	public Cliente(String nombre, String apellidos, String nie, int telefono, Sucursal sucubo) {
		this.nombre=nombre;
		this.apellidos=apellidos;
		this.nie=nie;
		this.telefono=telefono;
		this.sucursal=sucubo;
		sucubo.addCliente(this);
	}
	
	public void addCuenta(CuentasCorrientes cuenta) {
		cuentas.add(cuenta);
	}
}
