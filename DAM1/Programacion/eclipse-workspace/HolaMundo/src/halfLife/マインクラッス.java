package halfLife;

import java.util.function.Consumer;
import java.util.function.Supplier;

public class マインクラッス {

	public static void main(String[] args) {
		Operacion suma = (a,b) -> a+b;
		Operacion mayor = (a,b) -> {
			int m = a;
			if(b>a)
				m = b;
			return m;
		};
		IVA iva = (a,b) -> {
			double presio = a*(1+(b/100.0));
			//redondeo
			double redondeo = Math.round(presio*100.0)/100.0;
			return "PVP: "+redondeo +"€";
		};
		System.out.println(suma.ejecutar(5, 3));
		System.out.println(mayor.ejecutar(5, 3));
		System.out.println(iva.pvp(38.5,25));
		Runnable hola = () -> System.out.println("Hola Mundo");
		Runnable adios = () -> System.out.println("Adios Mundo");
		hola.run();
		adios.run();
		System.out.println();
		
		Consumer<String> saludo = (nombre) -> System.out.println("Hola " + nombre);
		Consumer<Integer> jubilacion = (edad) ->{
			if(edad>=67)
				System.out.println("Ya estas jubilado o puedes jubilarte cuando quieras");
			else
				System.out.println("Te faltan "+(67-edad) + " años para jubilarte");
		};
		saludo.accept("José María");
		jubilacion.accept(57);
		
		System.out.println();
		
		Supplier<Integer> dado = ()->(int) (Math.random()*6)+1;

		
		System.out.println(dado.get()
				);
	}

}
