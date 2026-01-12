package Banco;
import java.util.*;
public class CuentasCorrientes {
	private ArrayList<Cliente> titulare= new ArrayList<>();
	private int saldo;
	private Sucursal sucursal;
	private String codigo;
	
	public CuentasCorrientes(Cliente c1, int saldo, Sucursal sucursal, String codigo) {
		titulare.add(c1);
		c1.addCuenta(this);
		this.saldo=saldo;
		this.sucursal=sucursal;
		sucursal.addCuenta(this);
		this.codigo=codigo;
	}
	public CuentasCorrientes(Cliente c1, Cliente c2, int saldo, Sucursal sucursal, String codigo) {
		this.titulare.add(c1);
		this.titulare.add(c2);
		c1.addCuenta(this);
		c2.addCuenta(this);
		this.saldo=saldo;
		this.sucursal=sucursal;
		sucursal.addCuenta(this);
		this.codigo=codigo;
	}
}
