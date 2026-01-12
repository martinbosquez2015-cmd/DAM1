package Banco;

import java.util.ArrayList;

public class Sucursal {
	private Banco banco;
	private String calle;
	private int numero;
	private int codigoPostal;
	private String ciudad;
	private String codigo;
	
	private static ArrayList<CuentasCorrientes> cuentas= new ArrayList<>();
	private static ArrayList<Cliente> clientes = new ArrayList<>();
	
	public Sucursal(Banco banco, String calle, int numero, int codigoPostal, String ciudad, String codigo) {
		this.banco= banco;
		banco.addSuc(this);
		this.calle= calle;
		this.numero=numero;
		this.codigoPostal=codigoPostal;
		this.ciudad=ciudad;
		this.codigo=codigo;
		
		
	}
	
	public void addCliente(Cliente c1) {
		clientes.add(c1);
	}
	
	public void addCuenta(CuentasCorrientes c1) {
		cuentas.add(c1);
	}
	
	public void mostrar() {
		System.out.println("-----------------------------");
		System.out.print(this.calle+ " ");
		System.out.println(this.numero);
		System.out.println(this.codigoPostal);
		System.out.println(this.ciudad);
		System.out.println(this.codigo);
		System.out.println("-----------------------------");
	}
	
}
