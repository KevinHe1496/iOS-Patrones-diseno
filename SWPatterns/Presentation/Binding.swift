
import Foundation

// Clase genérica 'Binding' que permite enlazar un estado de tipo 'State' con una acción que se ejecutará cuando ese estado cambie.
final class Binding<State>{
    
    // Definimos un alias 'Completion' para una función que toma un valor de tipo 'State' y no devuelve nada.
    // Este es el tipo de función que se ejecutará cuando el estado cambie.
    typealias Completion = (State) -> Void
    
    // Variable opcional que almacenará la función (completion) a ejecutar cuando el estado cambie.
    var completion: Completion?
    
    // Método 'bind' que permite enlazar la función de actualización (completion) con el valor del estado.
    // Usamos '@escaping' porque la función se ejecutará más tarde, fuera del contexto inmediato.
    func bind(completion: @escaping Completion) {
        self.completion = completion // Guardamos la función en 'completion'.
    }
    
    // Método 'update' que recibe un nuevo valor de estado y lo notifica.
    func update(newValue: State) {
        // Ejecutamos la función en el hilo principal para asegurarnos de que cualquier cambio de UI ocurra de forma segura.
        DispatchQueue.main.async { [weak self] in
            // Si la función 'completion' existe, la ejecutamos con el nuevo valor.
            self?.completion?(newValue)
        }
    }
}
