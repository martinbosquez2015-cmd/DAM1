package EGP27;

import java.util.ArrayList;

import Banco.Cliente;
import Banco.CuentasCorrientes;

/**
 * Clase que representa un Pokémon con sus datos básicos.
 * 
 * Cada Pokémon tiene un código identificador, nombre, peso,
 * altura y uno o dos tipos.
 * 
 * Además, todos los Pokémon creados se guardan automáticamente
 * en una pokédex general.
 * 
 * @author TuNombre
 * @since 21/05/2026
 */
public class Pokemon implements Comparable<Pokemon>{
	
		private int codigo;
		private String nombre;
		private double peso;
		private double altura;
		private String[] tipo = new String[2];
		private static ArrayList <Pokemon> pokedex = new ArrayList<>();
		
		/**
		 * Constructor para crear un Pokémon de un solo tipo.
		 * 
		 * @param codigo Número identificador del Pokémon
		 * @param nombre Nombre del Pokémon
		 * @param peso Peso del Pokémon
		 * @param altura Altura del Pokémon
		 * @param tipo1 Tipo principal del Pokémon
		 */
		public Pokemon(int codigo, String nombre, double peso, double altura, String tipo1) {
			this.codigo=codigo;
			this.nombre=nombre;
			this.peso=peso;
			this.altura=altura;
			this.tipo[0]= tipo1;
			pokedex.add(this);
		}
		
		/**
		 * Constructor para crear un Pokémon con dos tipos.
		 * 
		 * @param codigo Número identificador del Pokémon
		 * @param nombre Nombre del Pokémon
		 * @param peso Peso del Pokémon
		 * @param altura Altura del Pokémon
		 * @param tipo1 Tipo principal
		 * @param tipo2 Tipo secundario
		 */
		public Pokemon(int codigo, String nombre, double peso, double altura, String tipo1, String tipo2) {
			this(codigo, nombre, peso, altura, tipo1);
			this.tipo[1]=tipo2;
		}
		
		/**
		 * Muestra por pantalla todos los Pokémon guardados
		 * en la pokédex.
		 */
		public static void mostrar() {
			for(Pokemon p:pokedex) {
				System.out.println(p.toString());
			}
		}
		
		/**
		 * Devuelve la lista completa de Pokémon registrados.
		 * 
		 * @return Lista con todos los Pokémon
		 */
		public static ArrayList<Pokemon> getCompleteList(){
			return pokedex;
		}
		
		/**
		 * Compara dos Pokémon usando el nombre en orden alfabético.
		 * 
		 * @param otro Pokémon con el que se compara
		 * @return Resultado de la comparación
		 */
		@Override
		public int compareTo(Pokemon otro){
			return this.nombre.compareTo(otro.nombre);
		}
		
		/**
		 * Genera una cadena con toda la información del Pokémon.
		 * 
		 * @return Información del Pokémon en formato texto
		 */
		@Override
		public String toString() {
			String linea = this.nombre+" (#"+this.codigo+") - ";
			
			if(this.tipo[1]==null) {
				linea+= this.tipo[0]+"\n";
			}
			else {
				linea+= this.tipo[0]+" y "+this.tipo[1]+"\n";
			}
			
			linea+="Peso: "+this.peso+"\nAltura: "+this.altura;
			
			return linea;
		}

}