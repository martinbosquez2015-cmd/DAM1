package BaseDeDatos;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class EGP26_01 {

	public static void main(String[] args) {
		System.out.println("EGP26_01inador versión 1.0");
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/classicmodels";
		int stockMinimo= 500;
		try (Connection conexion = DriverManager.getConnection(server, usuario, password)) {
			System.out.println("Estoy dentro");
			productosConMenorStock(conexion, stockMinimo);
			
			
		}catch(SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}
		
	}

	public static void productosConMenorStock(Connection cnx, int min) throws SQLException{
		PreparedStatement query = cnx.prepareStatement("SELECT productCode, productName, quantityInStock FROM products where quantityInStock<=?");
		query.setInt(1, min);
		ResultSet resultado = query.executeQuery();
		while(resultado.next()) {
			System.out.println(resultado.getString("productCode"));
			PreparedStatement query2 = cnx.prepareStatement("SELECT COUNT(*) FROM orderdetails WHERE productCode=?");
			query2.setString(1, resultado.getString("productCode"));
			ResultSet resultado2 = query2.executeQuery();
			resultado2.next();
			System.out.println(resultado2.getInt(1));
		}
		
	}
}
