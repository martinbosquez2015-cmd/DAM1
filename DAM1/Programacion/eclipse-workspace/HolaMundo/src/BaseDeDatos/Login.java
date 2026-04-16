package BaseDeDatos;

import javax.crypto.*;

import java.nio.charset.StandardCharsets;
import java.security.*;
import java.util.Base64;

public class Login {

	public static void main(String[] args) {
		String password = "abc123";
		
		
		//Generar Salt
		
		String saltTxt = generarSalt();
		System.out.println(saltTxt);
		System.out.println("Longitud de la salt: " + saltTxt.length());
		//String passwordConSalt = saltTxt + password;
		String hash = generarHash(saltTxt+password);
		System.out.println(hash);
		System.out.println("Longitud del hash: " + hash.length());

	}
	
	
	
	//generarSalt
	public static String generarSalt() {
		SecureRandom azar = new SecureRandom();
		byte[] salt = new byte[16];
		azar.nextBytes(salt);
		String saltTxt = Base64.getEncoder().encodeToString(salt);
		return saltTxt;
	}
	
	public static String generarHash(String txt) {
		String hashTxt=null;
		try {
		MessageDigest digest = MessageDigest.getInstance("SHA-512");
		byte[] hash = digest.digest(txt.getBytes(StandardCharsets.UTF_8));
		hashTxt= Base64.getEncoder().encodeToString(hash);
		}catch(Exception e) {
			System.out.println("El algoritmo SHA-512 no está disponible");
		}
		return hashTxt;
	}

}
