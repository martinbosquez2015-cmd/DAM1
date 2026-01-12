package Banco;

public class Main {
	public static void main(String[] args) {
		Banco banco1= new Banco("Créditos informáticos", "ES68 1234");
		Sucursal madrid1 = new Sucursal(banco1, "Calle de la percha foja", 10,28032, "Madrid",  "0078");
		Sucursal sevilla1= new Sucursal(banco1, "Calle de la espada destructora de mundos", 6, 38575, "Sevilla", "9596");
		Cliente c1= new Cliente("Juan Pablo", "Muñoz Giménez", "123456789Z", 604885599, madrid1);
		Cliente c2= new Cliente("Pablo Emilio","Escobar Gavidia", "123458679A", 606885723, sevilla1);
		CuentasCorrientes cuenta1 = new CuentasCorrientes(c1,100, madrid1, "123456789123");
		CuentasCorrientes cuenta2= new CuentasCorrientes(c2, 1000000000, sevilla1, "987654321123");
		
		banco1.listarSucursales();
		
		
	}
}
