// AsyncImageView.swift
// SWPatterns
// Created by Kevin Heredia on 2/10/24.

import UIKit

// Esta clase personalizada extiende UIImageView para cargar imágenes de manera asíncrona desde una URL.
final class AsyncImageView: UIImageView {
    
    // Propiedad privada para almacenar el objeto DispatchWorkItem, que permite controlar la operación en segundo plano.
    private var workItem: DispatchWorkItem?
    
    // Método que recibe un string (URL en formato de texto) y lo convierte en una URL válida para cargar la imagen.
    func setImage(_ string: String) {
        // Intenta crear una URL a partir del string, si tiene éxito llama al otro método setImage(url).
        if let url = URL(string: string) {
            setImage(url)
        }
    }
    
    // Método que recibe una URL y carga la imagen de esa URL de manera asíncrona.
    func setImage(_ url: URL) {
        // Crea un DispatchWorkItem que ejecutará el código de carga de imagen en un hilo secundario.
        let workItem = DispatchWorkItem {
            // Intenta descargar los datos de la URL. Si tiene éxito, convierte esos datos en una imagen UIImage.
            let image = (try? Data(contentsOf: url)).flatMap { UIImage(data: $0) }
            print("Loading image")
            
            // El bloque dentro de DispatchQueue.main.async se ejecuta en el hilo principal,
            // actualizando la interfaz de usuario con la imagen descargada.
            DispatchQueue.main.async { [weak self] in
                self?.image = image  // Asigna la imagen descargada al UIImageView.
                self?.workItem = nil  // Limpia el workItem porque la tarea ha terminado.
            }
        }
        
        // Ejecuta el trabajo de carga de imagen en un hilo de fondo.
        DispatchQueue.global().async(execute: workItem)
        // Almacena el workItem actual, lo que permitirá cancelarlo si es necesario.
        self.workItem = workItem
    }
    
    // Método que cancela cualquier tarea de carga de imagen en progreso.
    func cancel() {
        workItem?.cancel()  // Cancela el workItem si existe.
        workItem = nil  // Limpia el workItem para indicar que no hay ninguna tarea en ejecución.
    }
}
