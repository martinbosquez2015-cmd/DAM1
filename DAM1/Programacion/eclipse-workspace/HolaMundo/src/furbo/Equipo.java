package furbo;
import java.util.HashSet;
public class Equipo {
	private String nombre;
	private Entrenador entrenador;
	private HashSet<Jugador> alineacion;
	private int partidosGanados = 0;
	private int partidosEmpatados = 0;
	private int partidosPerdidos = 0;
	private int golesAFavor = 0;
	private int golesEnContra= 0;
	private int puntos = 0;
	
	public Equipo(String nombre) {
		this.nombre=nombre;
	}
	
	public void AddTrainer(Entrenador entrenador) {
		this.entrenador = entrenador;
	}
	public void addPlayer(Jugador jugador) {
		this.alineacion.add(jugador);
	}
}
