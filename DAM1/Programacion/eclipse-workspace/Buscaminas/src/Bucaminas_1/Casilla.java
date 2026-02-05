package Bucaminas_1;

public class Casilla {
	private int numero=0;
	private boolean descubierto= false;
	
	
	public int getNumero(){
		return this.numero;
	}
	public boolean getBoolean() {
		return this.descubierto;
	}
	public void setNumero(int num) {
		this.numero=num;
	}
	public void setBoolean(boolean si) {
		this.descubierto=si;
	}
}