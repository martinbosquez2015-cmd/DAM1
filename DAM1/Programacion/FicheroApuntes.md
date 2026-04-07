# Apuntes de JavaFicheros
    Existen diferentes métodos
## Lectura
1. __Método 1__:
    Este método usa dos objetos, uno que convierte la ruta en el fichero y otro que es como un dedo que lee línea por línea
    <br>
    ```
        public static void lectura1() {
		// Tratar las excepciones es obligatorio cuando se trabaja con ficheros
		try {
			// necesitamos dos objetos. FileReader simboliza al ficharo. Recibe como argumento el nombre 
			// o la ruta al mismo
			FileReader fichero = new FileReader("/mnt/temp/quijote.txt");
			// BufferedReader nos lo podemos imaginar como un cursor que apunta al lugar donde vamos leyendo
			// Como si señaláramos en un libro con el dedo la siguiente línea que nos toca leer
			// inicialmente apunta al principio del fichero
			BufferedReader lector = new BufferedReader(fichero);
			String linea;
			// Usamos un bucle para leer del fichero. Como al menos tendremos que leer una vez
			// la estructura do-while parece la mas correcta. Luego veremos una alternativa
			do{
				// readline lee una linea completa del fichero o null cuando hayamos llegado al final
				// el último caracter, el salto de línea si existe, que simbolizamos con \n se suprime cuando se lee
				linea = lector.readLine();
				if(linea!=null)
					System.out.println(linea);
			// cuando leamos null es nuestra condición de salida: hemos leído el fichero completo
			}while(linea!=null);
			// No olvidemos cerrar al final para no consumir recursos innecesariamente
			lector.close();
		// Existen excepciones concretas (FileNotFound, IOException) para la mayoría de problemas que 
		// puede haber con un fichero. Si usamos una excepción genérica, podemos ver que ocurre
		// exactamente con el método getMessage
		} catch (Exception e) {
			System.out.println("Error al leer: " + e.getMessage());
		}
	}
	```
2. __Método 2__: Método más compacto
    ```
	public static void lectura2() {
		// Este método es similar al anterior, pero mas compacto
		try {
			// Creamos en la misma sentencia los dos objetos que necesitamos
			BufferedReader lector = new BufferedReader(new FileReader("/mnt/temp/quijote.txt"));
			String linea;
			// Leemos las líneas del fichero en la condición el while y salimos si lo que leemos es null
			while ((linea = lector.readLine()) != null) {
				System.out.println(linea);
			}
			lector.close();
		} catch (Exception e) {
			System.out.println("Error al leer: " + e.getMessage());
		}
	}
    ```
3. __Método 3__: Aquí utilizamos el método de Scanner, pero lee el fichero línea por línea
    ``` 
	public static void lectura3() {
		try {
			// En este método vamos a usar la clase Scanner que ya conocemos de cuando leíamos del teclado
			// La clase File simboliza al fichero y scanner será nuestro cursor
			File fichero = new File("/mnt/temp/quijote.txt");
			Scanner scanner = new Scanner(fichero);
			// como condición de salida usamos hasNextLine que nos devuelve false cuando llegamos al final del fichero
			// y ya no hay mas líneas para leer y true mientras que esto no ocurra
			while (scanner.hasNextLine()) {
				// nextLine lee del fichero una línea completa, hasta que se encuentra un salto de línea
				// Al igual que en el caso anterior, también suprime los caracteres \n
				String linea = scanner.nextLine();
				System.out.println(linea);
			}
			scanner.close();
		} catch (Exception e) {
			System.out.println("Error al leer: " + e.getMessage());
		}
	}
    ```

4. __Método 4__: Este es el método estrella, será pasar el contenido del fichero por líneas a un ArrayList de Strings
    ```
public static void lectura4() {
		// En este método leeremos el fichero de una vez y lo guardaremos en un ArrayList donde cada elemento
		// es una línea del fichero. Necesitamos el objeto Path que simboliza la ruta al fichero
		// Path no necesitar ir dentro de la excepción
		Path ruta = Path.of("/home/josemaria/quijote.txt");
		ArrayList<String> lineas = null;
		try {
			// El método readAllLines lee el fichero completamente y luego lo cierra y almacena el contenido en un List
			// Como nosotros no hemos usado el objeto List (y el ArrayList que si conocemos es compatible y mas potente)
			// Usamos un cast
			lineas = (ArrayList<String>)Files.readAllLines(ruta);
			// No obstante, si quieres usar List sería así:
			// List<String> lineas = Files.readAllLines(ruta);
		} catch (Exception e) {
			System.out.println("Error al leer: " + e.getMessage());
		}
		// Para procesar el contenido, trabajamos con el ArrayList
		// También ha suprimido por nosotros los saltos de línea finales de cada línea
		for (String linea : lineas) {
			System.out.println(linea);
		}
	}
    ```

5. __Método 5__: Este método te guarda todo el contenido en un string, los saltos de línea se representan con el caracter "\n" que aquí solo es uno na mas(pero honestamente no tengo ni idea de como aplicarlo)
    ``` 
public static void lectura5() {
		// El último método lee todo el contenido del fichero como un único String
		Path ruta = Path.of("/home/josemaria/quijote.txt");
		String contenido = null;
		try {
			// leemos todo el contenido de una vez en un String
			// cuidado que aquí los saltos de línea siguen existiendo. Si nuestro fichero tuviera dos lineas así
			// uno
			// dos
			// contenido sería así: "uno\ndos"
			// El \n simboliza el salto de línea y ocupa un solo caracter y no dos
			contenido = Files.readString(ruta);
		} catch (Exception e) {
			System.out.println("Error al leer: " + e.getMessage());
		}
		System.out.print(contenido);
	}
    ```

## Escritura
1. __Método 1__: Para esta función será necesario solo un objeto. Ojo con las dos formas de crear el objeto, cuando pasas solo el argumento de la ruta, exista o no el archivo lo crea de nuevo y sobreescribe lo que había antes; si cuando creas el FileWriter pones como segundo argumento el true, lo que va a hacer es ver si es que el archivo existe, en el caso de que no exista crea uno nuevo, pero si el archivo existe entonces lo que hace es que añade contenido sin borrar lo anterior.

    ``` 
	public static void escritura1() {
		try {
			// si el fichero no existe se crea. Si existe se borra su contenido antes de
			// escribir
			FileWriter escritor = new FileWriter("/mnt/temp/java.txt");
			escritor.write("Hola, mundo con FileWriter!\n");
			escritor.write("Escribiendo una segunda línea.");
			System.out.println("Archivo escrito correctamente.");
			escritor.close();
		} catch (Exception e) {
			System.err.println("Error al escribir el archivo: " + e.getMessage());
		}
		try {
			// el segundo parámetro, true, indica que se añade al final (append) si el
			// fichero ya existe
			// si el fichero no existe se crea
			FileWriter escritor = new FileWriter("/mnt/temp/java.txt", true);
			escritor.write("\nEsta línea se añade al final.");
            escritor.close()
		} catch (Exception e) {
			System.err.println("Error al añadir al archivo: " + e.getMessage());
		}
	}
    ```
2. __Método 1 mejorado__: Este método es igual que el primero, pero resulta más profesional a la hora de manipular los ficheros, esto porque lo que hace es que se cierra el archiovo correctamente luejo de ejecutarse la sentencia del try, en el caso del método 1, tenías que cerrar el objeto de tripo FileWriter manualmente.
    ```
	public static void escritura1bis() {
		// Idem al anterior pero usamos try-with-resources para que el fichero se cierre
		// automáticamente
		try (FileWriter escritor = new FileWriter("/mnt/temp/java.txt")) {
			escritor.write("Hola, mundo con FileWriter!\n");
			escritor.write("Escribiendo una segunda línea.");
			// Podríamos escribir caracteres sueltos o arrays de char.
			System.out.println("Archivo escrito correctamente.");
		} catch (Exception e) {
			System.err.println("Error al escribir el archivo: " + e.getMessage());
		}
		// Idem para añadir
		try (FileWriter escritor = new FileWriter("/mnt/temp/java.txt", true)) {
			escritor.write("\nEsta línea se añade al final.");
		} catch (Exception e) {
			System.err.println("Error al añadir al archivo: " + e.getMessage());
		}
	}
    ```


3. __Método 2__: Este método es eficiente para archivos grandes, el objeto a usar sera de tipo BufferedWriter
aquí, igual que el método 1 mejorado, utilizamos la forma try-with resources para no olvidar de cerrar el objeto
    ```

	public static void escritura2() {
		// BufferedWriter es mas eficiente. sobre todo para grandes datos
		// Usa un buffer intermedio. Por lo mismo es mas crítico no olvidar cerrar el fichero
		// Podemos usar la estrategia de try-with-resource para no olvidarlo
		try (BufferedWriter escritor = new BufferedWriter(new FileWriter("/mnt/temp/java.txt"))) {
			escritor.write("Primera línea con Buffer.");
			// Escribe el salto de línea. Es mas portable porque si en el sistema en el que
			// se ejecuta se usa otro caracter diferente al \n lo tiene en cuenta
			escritor.newLine();
			escritor.write("Segunda línea. Es más eficiente.");
			escritor.newLine();
			// escritor.close();
			System.out.println("Archivo escrito eficientemente.");
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());
		}
		// y también podemos añadir
		try (BufferedWriter escritor = new BufferedWriter(new FileWriter("/mnt/temp/java.txt", true))) {
			escritor.write("Última línea.");
			System.out.println("Añadido.");
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());
		}
	}
    ```

4. __Método 4__: Con este método podemos escribir con formato, el tipo de objeto será PrintWriter
    ```
	public static void escritura3() {
		// PrintWriter nos permite grabar "con formato" de la misma forma que haríamos con printf
		// Podemos especificar el juego de caracteres que vamos a usar (opcional)
		try (PrintWriter escritor = new PrintWriter("/mnt/temp/java.txt", StandardCharsets.UTF_8)) {
			escritor.println("Línea 1: Hola con PrintWriter.");
			escritor.print("Línea 2: Esto no tiene salto de línea. ");
			escritor.println("Pero esto sí lo añade.");
			// Formateo de datos
			String nombre = "Ana";
			int edad = 30;
			double altura = 1.7589;
			escritor.printf("Usuario: %s, Edad: %d, Altura: %.2f m", nombre, edad, altura);
			escritor.println(); // Salto de línea adicional

			System.out.println("Archivo escrito con formato correctamente.");

			// Podemos comprobar si hubo errores que no generen excepción así:
			if (escritor.checkError()) {
				System.err.println("Ocurrió un error durante la escritura.");
			}

		} catch (Exception e) {
			System.err.println("Error al abrir/crear el archivo: " + e.getMessage());
		}
		// Para añadir con PrintWriter usamos también PrintWriter
		try (PrintWriter escritor = new PrintWriter(
                new FileWriter("/mnt/temp/java.txt", StandardCharsets.UTF_8, true))) {
            
            escritor.println("Esta línea se añade al final.");
            escritor.printf("Número de línea: %d%n", 42);
            
            System.out.println("Texto añadido correctamente con PrintWriter");
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
	}
    ```

5. __Método 5__: COn este puede meter listas en un fichero
    ```
	public static void escritura4() {
		// Ahora vamos a ver un método para grabar listas
		Path rutaArchivo = Paths.get("/mnt/temp/java.txt");
		ArrayList<String> lineas = new ArrayList<>(List.of("Primera Linea", "Segunda línea", "Tercera línea"));
		try {
			// Abre el fichero, escribe la lista (una línea por elemento) y luego cierra el fichero
			Files.write(rutaArchivo, lineas, StandardCharsets.UTF_8);
			System.out.println("Lista escrita en archivo.");
		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());
		}
		
		// y para añadir
		ArrayList<String> nuevasLineas = new ArrayList<>(List.of("Cuarta línea", "Quinta línea"));
		try {
            Files.write(
            	rutaArchivo, 
                nuevasLineas, 
                StandardCharsets.UTF_8,
                // StandardOpenOption.CREATE crea el fichero si no existe. Si no lo ponemos generaría una excepción si el fichero no existe, pero si existe añade
                StandardOpenOption.CREATE,   
                StandardOpenOption.APPEND
            );
            
            System.out.println("Líneas añadidas correctamente");
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
	}
    ```

5. __Método 6__: Este método es similar al anterior, pero en este caso metemos strigs en lugar de listas
    ```
	public static void escritura5() {
		// Similar al método anterior, pero para escribir Strings
		Path rutaArchivo = Paths.get("/mnt/temp/java.txt");
		String contenido = "Este es el contenido a escribir.\nSegunda línea.";
		try {
			// Abre el fichero, graba el string y lo cierra luego
			Files.writeString(rutaArchivo, contenido, StandardCharsets.UTF_8);
			System.out.println("Archivo escrito con Files.writeString");

			// Añadir más contenido (append). Funciona también igual que en el caso de las listas
			String masContenido = "\nAñadiendo más texto.";
			Files.writeString(rutaArchivo, masContenido, StandardCharsets.UTF_8, StandardOpenOption.CREATE, StandardOpenOption.APPEND);
			System.out.println("Texto añadido.");

		} catch (Exception e) {
			System.err.println("Error: " + e.getMessage());
		}
	}
    ```


## Escritura binaria
    Aquí solo hay dos métodos, uno para lectura y otro para escritura: InputStream y Output. Con estas formas podemos meter objetos tambien, pero es necesario que haya un metodo para cada tipo de objeto; y en la calse de objeto, se tiene que serializar con el constructor. 
    Ej:
``` 
package Ficheros;

import java.io.Serializable;

//Para poder grabar los objetos en un fichero y darles persistencia tienen que ser Serializables
public class Pokemon implements Serializable{ 
```

    otra cosa importante, cuando leas ficheros va a ser necesario que, si asignas variables, tomes en cuenta el orden en que escribiste las cosas, porque se reservan numeros de bits por cada tipo de dato. Por último, este método, si ve que no hay ningun fichero lo crea automáticamente.
- Método para escribir cosas normales:
```
public static void escribirFichero(String fichero) {
		// Fíjate que usamos "output" para escribir e "input" para leer. Puede parecer contradictorio
		// pero piensa que el punto de vista es el de la "persona" que lee o graba
		// cuando escribes es output porque los datos salen de ti hacia el fichero
		// cuando lees es input porque los datos vienen a ti desde el fichero
		 try (DataOutputStream binario = new DataOutputStream(new FileOutputStream(fichero))) {
	            // Lo mas importante a la hora de escribir en un fichero binario es que importa el tipo de datos
			 	// que se escribe. En los de texto no, porque siempre escribimos texto. Aquí usamos métodos distintos
			 	// por cada tipo de datos
			 	// Por lo demás, la estructura es muy similar
	            binario.writeInt(42);             
	            binario.writeDouble(3.14159);     
	            binario.writeBoolean(true);       
	            binario.writeUTF("Hola Mundo");   
	            binario.writeChar('A');           
	            
	            System.out.println("Datos escritos correctamente en " + fichero);         
	        } catch (Exception e) {
	            System.err.println("Error: " + e.getMessage());
	        }
	}
	
	public static void leerFichero(String fichero) {
		try (DataInputStream binario = new DataInputStream(new FileInputStream(fichero))) {
            
            // Tenemos que leer en el mismo orden y los mismos tipos que se escribieron
			// Prueba a intercambia el orden de las dos líneas siguientes y verás que lo que se lee
			// en ese caso es totalmente distinto a lo que escribiste
            int entero = binario.readInt();
            double decimal = binario.readDouble();
            boolean bool= binario.readBoolean();
            String texto = binario.readUTF();
            char caracter = binario.readChar();
            
            System.out.println("Datos leídos del fichero:");
            System.out.println("Entero: " + entero);
            System.out.println("Double: " + decimal);
            System.out.println("Booleano: " + bool);
            System.out.println("String: " + texto);
            System.out.println("Char: " + caracter);
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
	}
	
```
- Métodos para escribir sobre objetos y así:
```
	public static void main(String[] args) {
		// Los ficheros binarios guardan información no legible ni modificable directamente
		// ventajas: menos espacio, mas velocidad, permite guardar datos complejos y persistencia de objetos de forma mas cómoda
		String fichero = "/home/josemaria/binario.bin";
		
		// Persistencia de objetos
		Pokemon pokemon = new Pokemon(6, "Charizard", "Fuego", "Volador");
		guardarPokemon(pokemon, fichero);
		Pokemon pokemonRecuperado = recuperarPokemon(fichero);
		if(pokemonRecuperado!=null)
			pokemonRecuperado.mostrar();
		
		// Guardar y recuperar listas de objetos
		Pokemon p1 = new Pokemon(1, "Bulbasaur", "Planta");
		Pokemon p2 = new Pokemon(6, "Charizard", "Fuego", "Volador");
		Pokemon p3 = new Pokemon(2, "Ivysaur", "Planta");
		Pokemon p4 = new Pokemon(25, "Pikachu", "Eléctrico");
		Pokemon p5 = new Pokemon(11, "Metapod", "Bicho");
		Pokemon p6 = new Pokemon(7, "Squirtle", "Agua");
		ArrayList<Pokemon> listaPokemons = new ArrayList<>(List.of(p1, p2, p3, p4, p5, p6));
		guardarListaPokemons(listaPokemons, fichero);
		ArrayList<Pokemon> listaRecuperada = recuperarListaPokemons(fichero);
		for (Pokemon poke:listaRecuperada) {
			poke.mostrar();
		}
		
		// Si quisieramos añadir un pokemon a un fichero existente lo recuperamos, añadimos el fichero a la lista y volvemos a grabar
		Pokemon p7 = new Pokemon(131,"Lapras","Agua","Hielo");
		listaRecuperada = recuperarListaPokemons(fichero);
		listaRecuperada.add(p7);
		guardarListaPokemons(listaRecuperada, fichero);
		listaRecuperada = recuperarListaPokemons(fichero);
		for (Pokemon poke:listaRecuperada) {
			poke.mostrar();
		}
	}
    public static void guardarPokemon(Pokemon pokemon, String fichero) {
		// guardar un objeto es sumamente fácil. Usamos siempre el mismo método y no hace falta usar un "cast"
        try (ObjectOutputStream binario = new ObjectOutputStream(new FileOutputStream(fichero))) {
            binario.writeObject(pokemon);
            System.out.println("Pokemon guardado correctamente en " + fichero);
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
	}
	
	public static Pokemon recuperarPokemon(String fichero) {
		Pokemon pokemon = null;
        try (ObjectInputStream binario = new ObjectInputStream(new FileInputStream(fichero))) {
        	// Al leer, el cast al tipo de objeto es obligatorio
            pokemon = (Pokemon) binario.readObject();
            System.out.println("Pokemon recuperado correctamente");
            
        }catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
        return pokemon;
    }
	
	public static void guardarListaPokemons(ArrayList<Pokemon> lista, String fichero) {
		// Un método muy práctico para guardar y recuperar objetos sin preocuparnos de cuantos son es guardarlos en una lista
		// La lista se trata como un único objeto independientemente de su tamaño
        try (ObjectOutputStream binario = new ObjectOutputStream(new FileOutputStream(fichero))) {
            binario.writeObject(lista);
            System.out.println("Lista de Pokemons guardada correctamente en " + fichero);
            
        } catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
	}
	
	public static ArrayList<Pokemon> recuperarListaPokemons(String fichero) {
		ArrayList <Pokemon> lista = null;
        try (ObjectInputStream binario = new ObjectInputStream(new FileInputStream(fichero))) {        
        	// Al leer, la lista es también un único objeto de forma independiente a su tamaño
        	// No olvides el cast, que también hace falta
            lista = (ArrayList<Pokemon>) binario.readObject();
            System.out.println("Lista de Pokemons recuperada correctamente");
            
        }catch (Exception e) {
            System.err.println("Error: " + e.getMessage());
        }
        return lista;
    }
}
```
## Escritura binaria con bases de datos RandomAccessFile


### Consejillos y demás cosas para la creación de ejercicios
- Para saber si un fichero existe(en el caso de que solo hagamos lectura) puedes usar esta función:
```
	public static boolean existeElFichero(String fichero) {
		File f = new File(fichero);
		return (f.exists());
	}
```