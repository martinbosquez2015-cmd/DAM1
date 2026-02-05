package Bucaminas_1;

import java.util.Arrays;

public class Tablero {
	private int lado;
	private int minas;
	private Casilla[][] tabla;
	private int[][] tablasec;
	final static int MINA = -1;

	public Tablero(int lados, int minas) {
		this.lado = lados;
		this.minas = minas;
		this.tabla = new Casilla[lado][lado];
	}

	public void mostrarTablero() {
		for (int i = 0; i < lado; i++) {
			for (int j = 0; j < lado; j++) {
				Casilla casilla = tabla[i][j];
				if (casilla.getNumero() == -1) {
					System.out.print(" " + casilla.getNumero() + "  ");
				} else {
					System.out.print("  " + casilla.getNumero() + "  ");
				}
			}
			System.out.println();
		}
	}
	public void mostrarTablero2() {
		for (int i = 0; i < lado; i++) {
			for (int j = 0; j < lado; j++) {
				if (tablasec[i][j] == -1) {
					System.out.print(" " + tablasec[i][j] + "  ");
				} else {
					System.out.print("  " + tablasec[i][j] + "  ");
				}
			}
			System.out.println();
		}
	}

	public void mostrarTableroSec() {
		
		for (int i = 0; i < lado; i++) {
			for (int j = 0; j < lado; j++) {
				Casilla casilla = tabla[i][j];
				if (casilla.getBoolean() == false)
					System.out.print("*" + "  ");
				else 
					System.out.println(casilla.getNumero() + "  ");
			}
			System.out.println();
		}
	}

	public void colocarMina() {
		int numMina = 0;
		while (numMina != minas) {
			int fila = (int) (Math.random() * this.lado);
			int columna = (int) (Math.random() * this.lado);
			Casilla casilla = tabla[fila][columna];
			if (casilla.getNumero() == 0) {
				casilla.setNumero(MINA);
				numMina++;
			}

		}
	}

	public boolean HayMinas(int f, int c) {
		boolean haymina = false;
		Casilla casilla = tabla[f][c];
		if (casilla.getNumero() == MINA) {
			haymina = true;
		}
		return haymina;
	}

	public void seguirJugando(int f, int c) {
		Casilla casilla = tabla[f][c];
		if(casilla.getNumero()==0)
			casilla.setBoolean(true);
		this.tablasec[f][c]=9;
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
				else if (i==this.lado-1 && j!=0 && j!=this.lado-1) {
					if (this.tabla[i][j] != MINA) {
						if (this.tabla[i - 1][j] == MINA)
							contador++;
						if (this.tabla[i][j + 1] == MINA)
							contador++;
						if (this.tabla[i][j - 1] == MINA)
							contador++;
						if (this.tabla[i - 1][j + 1] == MINA)
							contador++;
						if (this.tabla[i - 1][j - 1] == MINA)
							contador++;
						this.tabla[i][j]=contador;
					}
				}
				else if(j==this.lado-1 && i!=0 && i!=this.lado-1) {
					if (this.tabla[i][j] != MINA) {
						if (this.tabla[i - 1][j] == MINA)
							contador++;
						if (this.tabla[i + 1][j] == MINA)
							contador++;
						if (this.tabla[i][j - 1] == MINA)
							contador++;
						if (this.tabla[i + 1][j - 1] == MINA)
							contador++;
						if (this.tabla[i - 1][j - 1] == MINA)
							contador++;
						this.tabla[i][j] = contador;
					}
				}
				else if(i==0 && j==0) {
					if (this.tabla[i][j] != MINA) {
						if (this.tabla[i][j + 1] == MINA)
							contador++;
						if (this.tabla[i + 1][j] == MINA)
							contador++;
						if (this.tabla[i + 1][j + 1] == MINA)
							contador++;
						this.tabla[i][j] = contador;
					}
				}
				else if(i==this.lado-1 && j==0) {
					if (this.tabla[i][j] != MINA) {
						if (this.tabla[i - 1][j] == MINA)
							contador++;
						if (this.tabla[i][j + 1] == MINA)
							contador++;
						if (this.tabla[i - 1][j + 1] == MINA)
							contador++;
						this.tabla[i][j] = contador;
					}
				}
				else if(i==this.lado-1 && j==this.lado-1) {
					if (this.tabla[i][j] != MINA) {
						if (this.tabla[i - 1][j] == MINA)
							contador++;
						if (this.tabla[i][j - 1] == MINA)
							contador++;
						if (this.tabla[i - 1][j - 1] == MINA)
							contador++;
						this.tabla[i][j] = contador;
					}
				}
				else if(i==0 && j==this.lado-1) {
					if (this.tabla[i][j] != MINA) {
						if (this.tabla[i + 1][j] == MINA)
							contador++;
						if (this.tabla[i][j - 1] == MINA)
							contador++;
						if (this.tabla[i + 1][j - 1] == MINA)
							contador++;
						this.tabla[i][j] = contador;
					}
				}
			}
			
		}
	}

}