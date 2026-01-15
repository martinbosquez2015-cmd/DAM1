package EGP15_01;
import java.time.LocalDate;
public class Consulta {
	private int codigo;
	private LocalDate fecha;
	private String motivo;
	private String consejo;
	
	public Consulta(LocalDate fecha) {
		this.fecha=fecha;
	}
	
}
