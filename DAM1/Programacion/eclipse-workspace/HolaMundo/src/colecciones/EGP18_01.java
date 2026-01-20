package colecciones;
import java.util.HashSet;
import java.util.Arrays;
public class EGP18_01 {

	public static void main(String[] args) {
		
		int n = 0;
		boolean si = false;
		while (si == false) {
			n = (int) (Math.random() * 100) + 1;
			int raiz = (int)Math.sqrt(n)+1;
			si=true;
			if(n%2==0)
				si=false;
			for(int i=3; i<raiz && si==true; i+=2) 
				if(n%i==0) 
					si=false;
				
			}
		System.out.println(n);

	}
}
