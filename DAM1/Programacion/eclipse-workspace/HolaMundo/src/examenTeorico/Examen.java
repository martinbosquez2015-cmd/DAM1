package examenTeorico;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashSet;
import java.util.Scanner;
public class Examen {
	private ArrayList<Pregunta> preguntas= new ArrayList<>(1);
	
	public Examen(HashSet<Pregunta> preguntas, int n) {
		ArrayList <Pregunta> preguntata= new ArrayList<>();
		for(Pregunta p: preguntas)
			preguntata.add(p);
		Collections.shuffle(preguntata);
		for(Pregunta p: preguntata) {
			if(this.preguntas.size()<n)
				this.preguntas.add(p);
		}
		
		
		
		
	}
	public void showP(){
		for(Pregunta p: this.preguntas)
			p.showQuestion();
	}
	
	public void resolve() {
		Scanner teclado = new Scanner(System.in);
		int contador=0;
		for(Pregunta p:this.preguntas) {
			int opc=0;
			
			do {
			p.showQuestion();
			System.out.print("Respuesta: ");
			opc = teclado.nextInt();
			System.out.println();
			if (opc>3)
				System.out.println("escibe bien la respuesta menso");
			}while(opc>3);
			if(p.comprobador(opc)) {
				System.out.println("bien");
				contador++;
			}
			else
				System.out.println("mal");
		}
		System.out.printf("El número de aciertos es: %d", contador);
	}
}
