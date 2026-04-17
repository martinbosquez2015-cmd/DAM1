package BaseDeDatos;

import java.sql.Statement;
import java.nio.charset.StandardCharsets;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Base64;
import java.util.Scanner;

public class Ej2 {
	public static void main(String[] args) {
		Scanner teclado = new Scanner(System.in);
		System.out.println("InicioDeSesioninador versión 1.0");
		String usuario = "admin";
		String password = "1234";
		String server = "jdbc:mysql://localhost:3306/";
		try (Connection conexion = DriverManager.getConnection(server, usuario, password)) {
			crearBase(conexion);
			System.out.println("Estoy dentro");
			int opc = 0;
			while (opc != 3) {
				desplegarMainMenu();
				System.out.println("\nPor favor, seleccione una opción:");
				opc = validador1(teclado);
				switch (opc) {
				case 1:
					login(conexion, teclado);
					break;
				case 2:
					registro(conexion, teclado);
					break;
				case 3:
					System.out.println("Bye");
					break;
				}
			}
		} catch (SQLException e) {
			System.out.println("Error: " + e.getMessage());
		}

	}

	public static void crearBase(Connection conexion) throws SQLException {
		String query1 = "CREATE DATABASE IF NOT EXISTS registros";
		String query2 = "USE registros";
		String query3 = "CREATE TABLE IF NOT exists usuario(id SMALLINT UNSIGNED AUTO_INCREMENT,nombre VARCHAR(50) NOT NULL,salt VARCHAR(24),hach VARCHAR(88),email VARCHAR(60),privilegios TINYINT DEFAULT 1,CONSTRAINT pk_id_usuario PRIMARY KEY(id))";

		Statement consulta = conexion.createStatement();
		consulta.executeUpdate(query1);
		consulta.executeUpdate(query2);
		consulta.executeUpdate(query3);
	}

	public static void desplegarMainMenu() {
		for (int i = 0; i < 60; i++) {
			System.out.print("=");
		}
		System.out.printf("\n%31s\n  1.-LOGIN\n  2.-REGISTRO\n  3.-SALIR\n", "MENÚ");
		for (int i = 0; i < 60; i++) {
			System.out.print("=");
		}
	}

	public static void registro(Connection conexion, Scanner teclado) throws SQLException {
		teclado.nextLine();
		String query1 = "USE registros";
		Statement consulta = conexion.createStatement();
		consulta.executeUpdate(query1);
		boolean si = false;
		String user="";
		String email="";
		String passwd="";
		while (si == false) {
			System.out.println("Por favor, Rellena los siguientes datos:");
			System.out.println("  Nombre de usuario: ");
			user = teclado.nextLine();
			System.out.println("  Email: ");
			email = teclado.nextLine();
			si = validadorUsuario(conexion, user, email);
		}
		si = false;
		while (si == false) {
			si= true;
			System.out.println("  Contraseña: ");
			passwd = teclado.nextLine();
			System.out.println("  Repita contraseña: ");
			String passwd2 = teclado.nextLine();
			if (passwd.equals(passwd2) == false) {
				System.out.println("Error: contraseñas no coinciden");
				si = false;
			}
		}
		String salt = generarSalt();
		String hash = generarHash(passwd+salt);
		System.out.println(salt);
		System.out.println("Longitud de la salt: " + salt.length());
		System.out.println(hash);
		System.out.println("Longitud del hash: " + hash.length());
		PreparedStatement query2 = conexion.prepareStatement("INSERT INTO `registros`.`usuario`(`nombre`,`salt`,`hach`,`email`)VALUES(?, ?, ?, ?)");
		query2.setString(1, user);
		query2.setString(2, salt);
		query2.setString(3, hash);
		query2.setString(4, email);
		query2.executeUpdate();

	}
	public static String generarSalt() {
		SecureRandom azar = new SecureRandom();
		byte[] salt = new byte[16];
		azar.nextBytes(salt);
		String saltTxt = Base64.getEncoder().encodeToString(salt);
		return saltTxt;
	}
	public static String generarHash(String passwdSlt) {
		String hashTxt=null;
		try {
		MessageDigest digest = MessageDigest.getInstance("SHA-512");
		byte[] hash = digest.digest(passwdSlt.getBytes(StandardCharsets.UTF_8));
		hashTxt= Base64.getEncoder().encodeToString(hash);
		}catch(Exception e) {
			System.out.println("El algoritmo SHA-512 no está disponible");
		}
		return hashTxt;
	}
	public static boolean validadorUsuario(Connection conexion, String user, String email)throws SQLException{
		boolean si= true;
			PreparedStatement query2 = conexion.prepareStatement("SELECT nombre FROM usuario where nombre = ? and email = ?", ResultSet.TYPE_SCROLL_INSENSITIVE, ResultSet.CONCUR_READ_ONLY);
			query2.setString(1, user);
			query2.setString(2, email);
			ResultSet resultado = query2.executeQuery();
			resultado.last();
			if(resultado.getRow()!=0) {
				si=false;
				System.out.println("Error: el usuario o el correo ya está registrado.");
			}
			
		return si;
	}

	public static void login(Connection conexion, Scanner teclado) throws SQLException {

	}

	public static int validador1(Scanner teclado) {
		boolean si = false;
		int opc = 0;
		while (si == false) {
			try {
				opc = teclado.nextInt();
				if (opc < 1 || opc > 3) {
					System.out.println("Error, opcion incorrecta, solo se peude elegir entre 1 y 2...");
				} else {
					si = true;
				}
			} catch (Exception e) {
				System.out.println("Error, vuelve a intentarlo...");
				teclado.nextLine();
			}

		}

		return opc;
	}

}
