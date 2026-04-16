package BaseDeDatos;

import java.beans.Statement;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class BaseDeDatos3 {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/";
		try (Connection conexion = DriverManager.getConnection(server, usuario, password)) {
			System.out.println("Estoy dentro");
			String query1 = "CREATE DATAFASE IF NOT EXISTS agenda";
			String query2 = "USE agenda";
			String query3 = "CREATE TABLE IF NOT EXISTS personas(telefono INT(9) PRIMARY KEY, nombre VARCHAR(50))";
			
			Statement consulta = conexion.createStatement();
			consulta.executeUpdate(query1);
			consulta.executeUpdate(query2);
			consulta.executeUpdate(query3);
		}catch (SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
	
	}

}
