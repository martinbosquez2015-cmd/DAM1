package Bucaminas_1;

public class Tablero {
	private int lado;
	private int minas;
	private int[][] tabla;
	final static int MINA = -1;

	public Tablero(int lados, int minas) {
		this.lado = lados;
		this.minas = minas;
		this.tabla = new int[lado][lado];
	}

	public void mostrarTablero() {
		for (int i = 0; i < lado; i++) {
			for (int j = 0; j < lado; j++) {
				if (tabla[i][j] == -1) {
					System.out.print(" " + tabla[i][j] + "  ");
				} else {
					System.out.print("  " + tabla[i][j] + "  ");
				}
			}
			System.out.println();
		}
	}

	public void mostrarTableroSec() {
		for (int i = 0; i < lado; i++) {
			for (int j = 0; j < lado; j++) {
				if (tabla[i][j] == 0 || tabla[i][j] == MINA)
					System.out.print("*" + "  ");
				else if (tabla[i][j] == 9)
					System.out.print(" " + "  ");
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
		boolean haymina = false;
		if (this.tabla[f][c] == MINA) {
			haymina = true;
		}
		return haymina;
	}

	public void seguirJugando(int f, int c) {
		this.tabla[f][c] = 9;
	}

	public void contadorMinas() {

		for (int i = 0; i < this.lado; i++) {
			for (int j = 0; j < this.lado; j++) {
				int contador = 0;
				if (i != 0 && j != 0 && i != this.lado - 1 && j != this.lado - 1) {
					if (this.tabla[i][j] != MINA) {
						if (this.tabla[i - 1][j] == MINA)
							contador++;
						if (this.tabla[i][j + 1] == MINA)
							contador++;
						if (this.tabla[i + 1][j] == MINA)
							contador++;
						if (this.tabla[i][j - 1] == MINA)
							contador++;
						if (this.tabla[i - 1][j + 1] == MINA)
							contador++;
						if (this.tabla[i + 1][j + 1] == MINA)
							contador++;
						if (this.tabla[i + 1][j - 1] == MINA)
							contador++;
						if (this.tabla[i - 1][j - 1] == MINA)
							contador++;
						this.tabla[i][j] = contador;
					}

				} else if (i == 0 && j != 0 && j != this.lado - 1) {
					if (this.tabla[i][j] != MINA) {
					if (this.tabla[i][j + 1] == MINA)
						contador++;
					if (this.tabla[i + 1][j] == MINA)
						contador++;
					if (this.tabla[i][j - 1] == MINA)
						contador++;
					if (this.tabla[i + 1][j + 1] == MINA)
						contador++;
					if (this.tabla[i + 1][j - 1] == MINA)
						contador++;
					this.tabla[i][j] = contador;
				}
				}
				else if (i!=0 && j==0 && i!=this.lado-1) {
					if(this.tabla[i][j]!=MINA) {
					if (this.tabla[i - 1][j] == MINA)
						contador++;
					if (this.tabla[i][j + 1] == MINA)
						contador++;
					if (this.tabla[i + 1][j] == MINA)
						contador++;
					if (this.tabla[i - 1][j + 1] == MINA)
						contador++;
					if (this.tabla[i + 1][j + 1] == MINA)
						contador++;
					this.tabla[i][j]= contador;
					}
				}
				else if (i==this.lado)
			}
		}
	}

}
