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
			/*Estos son para poder ir para atras o para adelante cuando busquemos con las querys,
			 * por defecto se pone que solo podamos ir para adelante, pero tambien. para poder cambiarlos, necesitamos
			 * cambiar las dos cosas*/
			// TYPE_FORDWARD_ONLY, TYPE_SCROLL_INSENSITIVE, TYPE_SCROLL_SENSITIVE
			// CONCUR_READ_ONLY, CONCUR_UPDATABLE
			//Statement query = conexion.createStatement(ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_UPDATABLE);
			//String consulta = "SELECT id,nombre_completo, email, tel_contacto FROM pacientes"; 
			PreparedStatement query = conexion.prepareStatement("SELECT id,nombre_completo, email, tel_contacto FROM pacientes WHERE nombre_completo = ? and email = ?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			//ResultSet resultado = query.executeQuery("SELECT * FROM actor");
			/*ResultSet resultado = query.executeQuery(consulta);*/
			query.setString(1, "Luis Miguel");
			query.setString(2, "luis");
			ResultSet resultado = query.executeQuery();
			resultado.last();
			System.out.println("El query tiene "+resultado.getRow()+" registros." );
			//resultado.absolute(3);
			//resultado.updateString("nombre_completo", "Luis Miguel");
			//resultado.updateRow();
			
			
			resultado.afterLast();
			while(resultado.previous()) {
				System.out.printf("|%-3d|%3d|%20s|%20s|%20s|\n",resultado.getRow(),resultado.getInt("id"),resultado.getString(2),resultado.getString("email"), resultado.getString(4));
			}
			
			//conexion.close();
		}catch(SQLException e) {
			System.out.println("Error: "+ e.getMessage());
		}

	}

}
