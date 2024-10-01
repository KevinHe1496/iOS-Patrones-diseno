import Foundation

// Definimos un enum que representa los posibles estados de la pantalla de "splash".
enum SplashState {
    case loading  // Cuando la pantalla está cargando.
    case error    // Si ocurre un error durante la carga.
    case ready    // Cuando la carga ha finalizado.
}

// Clase final que define la lógica de la pantalla de "SplashViewController".
final class SplashViewModel{
    
    var onStateChanged = Binding<SplashState>()
    
    // Función que simula una carga o proceso de inicialización.
    func load() {
        // Actualizamos el estado a 'loading' (la pantalla empieza a cargar).
        onStateChanged.update(newValue: .loading)
        // Usamos un hilo de fondo para simular un retraso (3 segundos en este caso).
        DispatchQueue.global().asyncAfter(deadline: .now() + 3) { [weak self] in
            DispatchQueue.main.async {
            // Después de 3 segundos, volvemos al hilo principal y actualizamos el estado a 'ready' (listo).
                self?.onStateChanged.update(newValue: .ready)
            }
            
            
        }
    }
}
