package examenTeorico;

import java.util.HashSet;
import java.util.ArrayList;
import java.util.Collections;

public class Pregunta {
	private String pregunta;
	private String respuestaF1;
	private String respuestaF2;
	private String respuestaV;
	private ArrayList<String> respuestas = new ArrayList<>();

	private static HashSet<Pregunta> preguntas = new HashSet<>();

	public Pregunta(String apartado, String r1, String r2, String r3) {
		this.pregunta = apartado;
		this.respuestaF1 = r1;
		this.respuestaF2 = r3;
		this.respuestaV = r2;
		this.respuestas.add(r1);
		this.respuestas.add(r2);
		this.respuestas.add(r3);
		this.preguntas.add(this);
	}

	public void showQuestion() {
		this.suffle();
		System.out.println(this.pregunta);
		int i = 1;
		for (int j=0; j<3; j++) {
			System.out.printf("%3d.-  %s\n", i, this.respuestas.get(j));	
		i++;
		}
	}
	public static HashSet<Pregunta> getList() {
		return Pregunta.preguntas;
	}
	public void suffle() {
		for(int i= this.respuestas.size()-1; i>0; i--) {
			int j = (int)(Math.random()*(i+1));
			String temp = respuestas.get(i);
			respuestas.set(i, respuestas.get(j));
			respuestas.set(j, temp);
			
		}
	}
	public boolean comprobador(int opc) {
		boolean si= false;
		if (this.respuestas.get(opc-1)==this.respuestaV)
			si= true;
		return si;
	}
}
