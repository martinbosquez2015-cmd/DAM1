package parte2;

public class Persona {
		//El private hace que los datos no se puean manipular de forma directa
		private String nombre;
		private String apellidos;
		private int edad;
		
		public Persona(String nom, String ape) {
			this.nombre=nom;
			this.apellidos=ape;
		}
		public void incrementarEdad() {
			//This hace referencia al primer objeto
			this.edad++;
		}
		public void mostrar() {
			System.out.println(this.apellidos+", "+this.nombre+" "+this.edad);
		}
}
