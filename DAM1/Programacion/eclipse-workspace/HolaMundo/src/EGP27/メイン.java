package EGP27;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collections;

public class メイン {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/pokemondb";
		try (Connection conexion = DriverManager.getConnection(server, usuario, password)) {
			System.out.println("Conexion realizada con éxito");
			listaPokemon(conexion);
		}catch(SQLException e) {
			System.out.println("ERROR: "+e.getMessage());
		}
		Pokemon.mostrar();
		ArrayList <Pokemon> listaPokemon = new ArrayList<>();
		listaPokemon= Pokemon.getCompleteList();
		Collections.sort(listaPokemon);
		
		System.out.println("=======================================================");
		System.out.println();
		for(Pokemon p: listaPokemon) {
			System.out.println("----------------------------");
			System.out.println(p.toString());
			System.out.println("----------------------------");
		}
		


	}
	public static void listaPokemon(Connection conexion)throws SQLException{
		String query1 = "SELECT numero_pokedex from pokemon";
		String query2 = "SELECT p.numero_pokedex, p.nombre, p.peso, p.altura, t.nombre FROM pokemon as p JOIN pokemon_tipo USING(numero_pokedex) JOIN tipo as t USING(id_tipo) where numero_pokedex = ?";
		PreparedStatement consulta1 = conexion.prepareStatement(query1);
		ResultSet resultado1= consulta1.executeQuery();
		//no olvidarse siempre de posicionar el cursor antes de acceder a los resultados
		while (resultado1.next()) {
			PreparedStatement consulta2 = conexion.prepareStatement(query2,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			consulta2.setInt(1, resultado1.getInt(1));
			ResultSet resultado2 = consulta2.executeQuery();
			resultado2.last();
			int numTip= resultado2.getRow();
			resultado2.first();
			if(numTip==2) {
				String tipo1= resultado2.getString(5);
				resultado2.next();
				Pokemon p = new Pokemon(resultado2.getInt(1),resultado2.getString(2),resultado2.getDouble(3),resultado2.getDouble(4),tipo1,resultado2.getString(5));
				
			}
			else {
				Pokemon p = new Pokemon(resultado2.getInt(1),resultado2.getString(2),resultado2.getDouble(3),resultado2.getDouble(4),resultado2.getString(5));
			}
			
		}
		
	}

}
