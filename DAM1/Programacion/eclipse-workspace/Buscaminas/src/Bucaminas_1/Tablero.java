package Bucaminas_1;

public class Tablero {
	private int lado;
	private int minas;
	private int[][] tabla;
	final static int MINA = 1;

	public Tablero(int lados, int minas) {
		this.lado = lados;
		this.minas = minas;
		this.tabla = new int[lado][lado];
	}

	public void mostrarTablero() {
		for (int i = 0; i < lado; i++) {
			for (int j = 0; j < lado; j++) {
				System.out.print(tabla[i][j] + "  ");
			}
			System.out.println();
		}
	}
	
	public void mostrarTableroSec() {
		for (int i = 0; i < lado; i++) {
			for (int j = 0; j < lado; j++) {
				if (tabla[i][j]==0||tabla[i][j]==MINA)
				System.out.print("*" + "  ");
				else if (tabla[i][j]==2) 
					System.out.print("_"+ "  ");
			}
			System.out.println();
		}
	}

	public void colocarMina() {
		int numMina = 0;
		while (numMina != minas) {
			int fila = (int) (Math.random() * this.lado);
			int columna = (int) (Math.random() * this.lado);
			if (this.tabla[fila][columna] == 0) {
				this.tabla[fila][columna] = MINA;
				numMina++;
			}

		}
	}
	public boolean HayMinas(int f, int c) {
		boolean haymina=false;
		if (this.tabla[f][c]==MINA) {
			haymina=true;
		}
		return haymina;
	}
	public void seguirJugando(int f, int c) {
		this.tabla[f][c]=2;
	}

}
