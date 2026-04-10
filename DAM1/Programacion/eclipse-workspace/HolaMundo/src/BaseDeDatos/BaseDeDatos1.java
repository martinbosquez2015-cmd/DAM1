package BaseDeDatos;
import java.sql.*;
public class BaseDeDatos1 {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/sakila";
		try {
			Connection conexion;
			conexion = DriveManager.getConnection(server, usuario, password);
			conexion.close
		}catch(SQLException e) {
			System.out.println("Error: "+ e.get);
		}

	}

}
