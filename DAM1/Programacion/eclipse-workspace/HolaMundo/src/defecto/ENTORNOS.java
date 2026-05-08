import java.util.Vector;

public class ENTORNOS {
	private static final double IVA_LUJO = 0.21;

	public static void main(String[] args) {
		System.out.println("Una patata");
		
		String Cadena = "patata";
		Cadena += "hola";
		
		StringBuilder bs = new StringBuilder();
		
		bs.append(false);
		
	}

	public double calcularIva(double precio) {
		return precio*IVA_LUJO;
	}
	public double calcularDivision(double numerador, double denominador) throws Exception{
		return numerador/denominador;
		
	}
}
