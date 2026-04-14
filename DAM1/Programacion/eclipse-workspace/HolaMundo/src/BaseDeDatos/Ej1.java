package BaseDeDatos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class Ej1 {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/sakila";
		Scanner teclado = new Scanner(System.in);
		try (Connection 
			conexion = DriverManager.getConnection(server, usuario, password)){
			System.out.println("Estoy dentro");
			
	
			
			PreparedStatement query = conexion.prepareStatement("SELECT * FROM actor WHERE first_name = ?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			System.out.println("Por favor, escribe de pila del o de los actores que quieras buscar: ");
			String nombrePila = teclado.nextLine();
			query.setString(1,nombrePila);
			ResultSet resultado = query.executeQuery();
			resultado.last();
			System.out.println("Su consulta tiene "+resultado.getRow()+" resultados.");
			resultado.beforeFirst();
			while(resultado.next()) {
				System.out.printf("|%-3d|%3d|%20s|%20s|%20s|\n",resultado.getRow(),resultado.getInt(1),resultado.getString(2),resultado.getString(3), resultado.getString(4));
			}
		}catch( SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
			
			
			

	}

}
