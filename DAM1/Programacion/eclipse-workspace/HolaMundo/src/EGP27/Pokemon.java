package EGP27;

import java.util.ArrayList;

import Banco.Cliente;
import Banco.CuentasCorrientes;

public class Pokemon implements Comparable<Pokemon>{
	
		private int codigo;
		private String nombre;
		private double peso;
		private double altura;
		private ArrayList <String> tipo = new ArrayList<>();
		private static ArrayList <Pokemon> pokedex = new ArrayList<>();
		
		public Pokemon(int codigo, String nombre, double peso, double altura, String tipo1) {
			this.codigo=codigo;
			this.nombre=nombre;
			this.peso=peso;
			this.altura=altura;
			this.tipo.add(tipo1);
			pokedex.add(this);
		}
		public Pokemon(int codigo, String nombre, double peso, double altura, String tipo1, String tipo2) {
			this.codigo=codigo;
			this.nombre=nombre;
			this.peso=peso;
			this.altura=altura;
			this.tipo.add(tipo1);
			this.tipo.add(tipo2);
			pokedex.add(this);
		}
		public static void mostrar() {
			for(Pokemon p:pokedex) {
				System.out.println(p.toString());
			}
		}
		
		@Override
		public int compareTo(Pokemon otro){
			return this.nombre.compareTo(otro.nombre);
		}
		@Override
		public String toString() {
			String linea = this.nombre+" (#"+this.codigo+") - ";
			if(this.tipo.size()==1) {
				linea+= this.tipo.get(0)+"\n";
			}
			else
				linea+= this.tipo.get(0)+" y "+this.tipo.get(1)+"\n";
			linea+="Peso: "+this.peso+"\nAltura: "+this.altura;
			
			return linea;
		}
		
		
		
		

}
