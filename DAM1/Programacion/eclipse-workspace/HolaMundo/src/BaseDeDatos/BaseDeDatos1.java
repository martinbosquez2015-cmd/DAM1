package BaseDeDatos;

import java.sql.*;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;


public class BaseDeDatos1 {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/gha_analytics";
		try (Connection 
			conexion = DriverManager.getConnection(server, usuario, password)){
			
			System.out.println("Estoy dentro");
			
			Statement query = conexion.createStatement();
			String consulta = "SELECT id,nombre_completo, email, tel_contacto FROM pacientes"; 
			//ResultSet resultado = query.executeQuery("SELECT * FROM actor");
			ResultSet resultado = query.executeQuery(consulta);
			resultado.afterLast();
			while(resultado.next()) {
				System.out.printf("|%-3d|%3d|%20s|%20s|%11s|\n",resultado.getRow(),resultado.getInt("id"),resultado.getString(2),resultado.getString("email"), resultado.getString(4));
			}
			
			//conexion.close();
		}catch(SQLException e) {
			System.out.println("Error: "+ e.getMessage());
		}

	}

}
