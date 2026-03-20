package Ventanas;

import java.awt.FlowLayout;

import javax.swing.JButton;
import javax.swing.JFrame;
import javax.swing.JLabel;
import javax.swing.JOptionPane;
import javax.swing.JTextArea;

public class swing02 {

	public static void main(String[] args) {
		JFrame frame = new JFrame("Nombre de la ventana"); // Creamos la ventana con un titulo
		frame.setSize(800,600); //le asignamos un tamaño
		//frame.setLocation(0,0); //Definimos el origen de coordenadas de la ventana
		frame.setLocationRelativeTo(null);//Centra la ventana en la pantalla
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);//definimos que pasará cuando pulsemos el botón de cerrar
		frame.setVisible(true); //La hacemos visible
		
		//metemos un boton
		JButton button = new JButton("Texto boton");
		frame.add(button);
		
		frame.setLayout(new FlowLayout());//esto es para que el boton no ocupe un texto todo grandote
		
		
		JTextArea ciclosTextArea = new JTextArea(15,20);

		//Muestra un mensaje no editable
		JLabel label = new JLabel("nombre");
		 Ventana ventana = new Ventana();
		 ventana.setVisible(true);

		//Muestra un cuadro de diálogo con un mensaje
		JOptionPane.showMessageDialog(Ventana.this, "Eggs are not supposed to be green.");
	}

}
