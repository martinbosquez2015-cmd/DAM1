package TaboadaMartin_Examen2Trimestre3;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Práctica1 {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/classicmodels";
		String ciudad = "Paris";
		try (Connection conexion = DriverManager.getConnection(server, usuario, password)) {
			System.out.println("Conexion realizada con éxito");
			listarEmpleadosporCiudad(conexion, ciudad);
		}catch(SQLException e) {
			System.out.println("ERROR: "+e.getMessage());
		}

	}
	public static void listarEmpleadosporCiudad(Connection conexion, String ciudad) throws SQLException{
		//  String query1 = "SELECT lastName, firstName, email FROM offices JOIN employees USING(officeCode) WHERE officeCode =(SELECT officeCode FROM offices o2 WHERE city=?)";
		//El Marcos me amaodia
		String query2 = "SELECT officeCode FROM offices WHERE city=?";
		String query3 = "SELECT lastName, firstName, email FROM employees WHERE officeCode=?";
		PreparedStatement consulta1 = conexion.prepareStatement(query2,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
		consulta1.setString(1, ciudad);
		ResultSet resultado1 = consulta1.executeQuery();
		resultado1.last();
		if (resultado1.getRow()==0) {
			System.out.printf("No existe oficina en %s\n", ciudad);
		}
		else {
			resultado1.first();
			PreparedStatement consulta2 = conexion.prepareStatement(query3,ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			consulta2.setInt(1, resultado1.getInt(1));
			ResultSet resultado2 = consulta2.executeQuery();
			resultado2.last();
			System.out.printf("Hay %d empleados en la oficina de %s. Sus datos son:\n",resultado2.getRow(), ciudad);
			resultado2.beforeFirst();
			while(resultado2.next()) {
				System.out.printf(" - %s,%s (%s)\n",resultado2.getString(1),resultado2.getString(2),resultado2.getString(3));
			}
		}
	}

}
