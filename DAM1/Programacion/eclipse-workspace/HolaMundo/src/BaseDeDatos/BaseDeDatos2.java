package BaseDeDatos;

import java.net.MulticastSocket;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import javax.swing.JFrame;
import javax.swing.JScrollPane;
import javax.swing.JTable;
import javax.swing.table.DefaultTableModel;

public class BaseDeDatos2 {

	public static void main(String[] args) {
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/sakila";
		try (Connection conexion = DriverManager.getConnection(server, usuario, password)) {

			System.out.println("Estoy dentro");
			//ESTO ES PARA MODIFICAR COSAS EN LA BASE DE DATOS
			//el prepared statement es mejor que un statement
			/*PreparedStatement query = conexion.prepareStatement("INSERT INTO actor VALUES (NULL, ?,?,?)");
			query.setString(1, "Jose María");
			query.setString(2, "Morales");
			LocalDateTime fechayHora = LocalDateTime.now();
			DateTimeFormatter formato = DateTimeFormatter.ofPattern("YYYY-MM-dd HH:mm:ss");
			String fechaFormateada = fechayHora.format(formato);
			query.setString(3, fechaFormateada);
			query.executeUpdate();*/
			//Esto es para ELIMINAR COSAS EN LA BASE DE DATOS
			/*
			Statement query = conexion.createStatement();
			qury.executeUpdate("DELETE FROM actor WHERE last_name='Morales'");*/
			
			Statement consulta = conexion.createStatement();
			ResultSet resultado = consulta.executeQuery("SHOW TABLES");
			while(resultado.next()) {
				System.out.println(resultado.getString(1));
			}
			
			ResultSet actores = consulta.executeQuery("SELECT * FROM actor");
			/*System.out.printf("|%3s|%45s|%45s|%20s|\n|%0116d|\n", "id", "Nombre", "Apellido", "Ùltima actualización",0);
			while(actores.next()) {
				System.out.printf("|%03d|%45s|%45s|%20s|\n", actores.getInt(1), actores.getString(2),actores.getString(3),actores.getString(4));
			}
			*/
			JFrame ventana = new JFrame("Tabla actor");
		
			DefaultTableModel modelo = new DefaultTableModel();
			JTable tabla = new JTable(modelo);
			
			modelo.addColumn("id");
			modelo.addColumn("nombre");
			modelo.addColumn("Apellido");
			modelo.addColumn("Fecha");
			
			JScrollPane scroll = new JScrollPane(tabla);
			ventana.getContentPane().add(scroll);
			
			while(actores.next()) {
				Object[] fila = new Object[4];
				fila[0] = actores.getInt(1);
				fila[1] = actores.getString(2);
				fila[2] = actores.getString(3);
				fila[3] = actores.getString(4);
				modelo.addRow(fila);
			}
			ventana.pack();
			ventana.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			ventana.setVisible(true);
			
		} catch (SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}

	}

}
;