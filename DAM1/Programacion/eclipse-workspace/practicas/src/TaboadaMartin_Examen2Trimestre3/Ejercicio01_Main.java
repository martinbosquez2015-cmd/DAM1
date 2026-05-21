package TaboadaMartin_Examen2Trimestre3;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Ejercicio01_Main {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/pokemondb";
		try (Connection conexion = DriverManager.getConnection(server, usuario, password)) {
			System.out.println("Conexion realizada con éxito");
			evolucion(conexion, "Bulbasaur");

		} catch (SQLException e) {
			System.out.println("ERROR: " + e.getMessage());
		}

	}

	public static void evolucion(Connection conexion, String pok) throws SQLException {
		PreparedStatement query1 = conexion.prepareStatement("Select * from pokemon where nombre=?",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		PreparedStatement query2 = conexion.prepareStatement("select numero_pokedex,nombre from pokemon left join evoluciona_de on pokemon.numero_pokedex=evoluciona_de.pokemon_evolucionado where pokemon_origen=(Select numero_pokedex from pokemon where nombre=?)",ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		PreparedStatement query3 = conexion.prepareStatement("select p2.numero_pokedex,p2.nombre from pokemon as p1 left join evoluciona_de on p1.numero_pokedex=evoluciona_de.pokemon_evolucionado join pokemon p2 on p2.numero_pokedex=pokemon_origen where pokemon_evolucionado=(Select numero_pokedex from pokemon where nombre=?)", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		query1.setString(1, pok);
		ResultSet resultado = query1.executeQuery();
		resultado.last();
		if(resultado.getRow()==0) {
			System.out.printf("El Pokemon %s no está en la pokedex o no es de la primera generacion", pok);
			
		}
		else {
			resultado.first();
			System.out.printf("%s (#%d)", resultado.getString(2), resultado.getInt(1));
			
			
			query2.setString(1, pok);
			ResultSet resultado2 = query2.executeQuery();
			resultado2.last();
			if(resultado2.getRow()==0) {
				System.out.println("No evolucione en ninguno");
			}
			else {
				System.out.print("- Evoluciona en ");
				resultado2.beforeFirst();
				while(resultado2.next()) {
					System.out.printf("%s (#%d)", resultado.getString(2), resultado.getInt(1));
				}
				System.out.println();
					
			}
			query3.setString(1, pok);
			ResultSet resultado3 = query3.executeQuery();
			resultado.last();
			if(resultado3.getRow()==0) {
				System.out.println("No evoluciona de ninguno");
			}
			else {
				resultado3.first();
				System.out.printf("Evoluciona de %s (#%d)", resultado.getString(2), resultado.getInt(1));
			}
			System.out.println();
		}
	}

}
