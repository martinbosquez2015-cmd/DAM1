package interfaces;

public interface Jubilada {
/*Todos los atributos de una interfaz tienen que ser públicos, estáticos o finales*/
	int EDAD_JUBILACION = 67;
	void cuantoMeFalta();//Esto hace que todas las clases con esta inferface tengan que implementar este nombre del método
	
	static void mePuedoJubilar(int edad) {
		if(edad < EDAD_JUBILACION)
			System.out.println("sorry bro, aun no te puedes jubilar");
		else if(edad>EDAD_JUBILACION) 
			System.out.println("Ya te pasaste, deberías estar jubilado");
		else
			System.out.println("Corre que estás en la edad justa");
		
	}
	default void informacion() {
		System.out.println("Edad corriente de jubilación: "+EDAD_JUBILACION);
	}
}
