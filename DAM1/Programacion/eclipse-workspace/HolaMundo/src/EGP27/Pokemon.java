package EGP27;

import java.util.ArrayList;

import Banco.Cliente;
import Banco.CuentasCorrientes;

public class Pokemon implements Comparable<Pokemon>{
	
		private int codigo;
		private String nombre;
		private double peso;
		private double altura;
		private String[] tipo = new String[2];
		private static ArrayList <Pokemon> pokedex = new ArrayList<>();
		
		public Pokemon(int codigo, String nombre, double peso, double altura, String tipo1) {
			this.codigo=codigo;
			this.nombre=nombre;
			this.peso=peso;
			this.altura=altura;
			this.tipo[0]= tipo1;
			pokedex.add(this);
		}
		public Pokemon(int codigo, String nombre, double peso, double altura, String tipo1, String tipo2) {
			this(codigo, nombre, peso, altura, tipo1);
			this.tipo[1]=tipo2;
			pokedex.add(this);
		}
		public static void mostrar() {
			for(Pokemon p:pokedex) {
				System.out.println(p.toString());
			}
		}
		public static ArrayList<Pokemon> getCompleteList(){
			return pokedex;
		}
		
		@Override
		/*Man, te recuerdo que el compare to funciona con la devolución de unos y menos unos, por lo que dependiendo de lo que salga
		 * se puden añadir condiciones, en este caso solo se hace así para que la cosa sea más rápida*/
		public int compareTo(Pokemon otro){
			return this.nombre.compareTo(otro.nombre);
		}
		@Override
		public String toString() {
			String linea = this.nombre+" (#"+this.codigo+") - ";
			if(this.tipo[1]==null) {
				linea+= this.tipo[0]+"\n";
			}
			else
				linea+= this.tipo[0]+" y "+this.tipo[1]+"\n";
			linea+="Peso: "+this.peso+"\nAltura: "+this.altura;
			
			return linea;
		}
		
		
		
		

}
