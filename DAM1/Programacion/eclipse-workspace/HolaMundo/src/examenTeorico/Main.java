package examenTeorico;

public class Main {

	public static void main(String[] args) {
		Pregunta p1 = new Pregunta ("¿Qué indican las señales azules circulares?", "Peligro", "Obligación", "Prohibición");
		

Pregunta p2  = new Pregunta("¿Qué indica una señal triangular con borde rojo?", 
                "Obligación", 
                "Peligro", 
                "Información");

Pregunta p3  = new Pregunta("¿Qué significa una señal circular con borde rojo?", 
                "Información", 
                "Prohibición", 
                "Obligación");

Pregunta p4  = new Pregunta("¿Qué debe hacer ante una luz roja del semáforo?", 
                "Reducir la velocidad", 
                "Detenerse", 
                "Continuar con precaución");

Pregunta p5  = new Pregunta("¿Qué indica una línea continua en la calzada?", 
                "Permite adelantar", 
                "Prohíbe adelantar", 
                "Permite cambiar de carril");

Pregunta p6  = new Pregunta("¿Cuál es la velocidad máxima en una vía urbana?", 
                "30 km/h", 
                "50 km/h", 
                "90 km/h");

Pregunta p7  = new Pregunta("¿Quién tiene prioridad en un paso de peatones sin semáforo?", 
                "Los vehículos", 
                "Los peatones", 
                "Los ciclistas");

Pregunta p8  = new Pregunta("¿Qué debe hacer si escucha una sirena de emergencia?", 
                "Aumentar la velocidad", 
                "Facilitar el paso", 
                "Detenerse en seco");

Pregunta p9  = new Pregunta("¿Qué indica una señal rectangular azul?", 
                "Prohibición", 
                "Información", 
                "Peligro");

Pregunta p10 = new Pregunta("¿Qué debe hacer al acercarse a un stop?", 
                "Reducir velocidad", 
                "Detenerse completamente", 
                "Ceder solo si vienen vehículos");
	//p1.showQuestion();
	Examen e1 = new Examen( Pregunta.getList(),3);
	//e1.showP();
	
	e1.resolve();
	}

}
