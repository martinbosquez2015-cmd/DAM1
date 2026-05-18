package EGP28;

public class EGP28_01 {
	
	final int DESCUENTO_10_EUROS = 1;
	final int DESCUENTO_20_PORCIENTO =2;
	final int SIN_DESCUENTO = 3;
	
	public static void main(String[] args) {
		Descuento desc = (a,b) ->{
			final int descuento1 = 10;
			final double descuento2 = 0.2;
			double descAplicado = a;
			switch (b) {
			case 1:
				if(a>=30)
					descAplicado -=10;
				break;
			case 2:
				descAplicado -= descAplicado*descuento2;
				break;
			case 3: 
				break;
			default:
				System.out.println("Tipo de descuento desconocido");
				break;
			}
			return descAplicado;
		};
		
	}
}
