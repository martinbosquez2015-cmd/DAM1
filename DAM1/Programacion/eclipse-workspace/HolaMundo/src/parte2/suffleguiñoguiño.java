package parte2;
import java.util.ArrayList;
public class suffleguiñoguiño {

	public static void main(String[] args) {
		
		        ArrayList<Integer> lista = new ArrayList<>();
		        for (int i = 1; i <= 10; i++) lista.add(i);
		        System.out.println("Original: " + lista);

		        // Algoritmo de Fisher-Yates manual
		        for (int i = lista.size() - 1; i > 0; i--) {
		            // Math.random() genera un double entre 0.0 y 1.0
		            int j = (int) (Math.random() * (i + 1));
		            
		            // Intercambiar elementos (swap)
		            Integer temp = lista.get(i);
		            lista.set(i, lista.get(j));
		            lista.set(j, temp);
		        }

		        System.out.println("Desordenada: " + lista);
		    
		


	}

}
