package TaboadaMartin_Examen2Trimestre3;


public class Ejercicio03_Main {

	public static void main(String[] args) {
		Ejercicio03_Interface voltear = (cadena)->{
			String cadInv= "";
			cadena =cadena.trim();
			for (int i=cadena.length()-1; i>=0; i--) {
				cadInv+= cadena.charAt(i);
			}
			return cadInv;	
		};
		Ejercicio03_Interface guion = (cadena) -> {
			String cadGui = "";
			cadena =cadena.trim();
			for(int i=0; i<cadena.length(); i++) {
				cadGui+= cadena.charAt(i);
				if(i<cadena.length()-1)
					cadGui+="-";
			}
			return cadGui;
		};
		Ejercicio03_Interface espacios = (cadena) -> {
			String cadSinEsp = "";
			for(int i=0; i<cadena.length(); i++) {
				if(cadena.charAt(i)!= ' ')
					cadSinEsp+=cadena.charAt(i);
			}
			return cadSinEsp;
		};
		
		
		
		
		
		System.out.println(voltear.encadenar("hola"));
		System.out.println(guion.encadenar("hola "));
		System.out.println(espacios.encadenar("hola mundo "));

	}

}
