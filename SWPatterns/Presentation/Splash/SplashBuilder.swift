import UIKit

// Esta clase 'SplashBuilder' se encarga de construir y devolver una instancia configurada de la pantalla de "splash".
final class SplashBuilder {

    // Este método 'build' crea todo lo necesario para que la pantalla de "splash" funcione.
    func build() -> UIViewController {
        // Primero, crea una instancia del 'SplashViewModel', que contiene la lógica del "splash".
        let viewModel = SplashViewModel()

        // Luego, crea y devuelve una instancia de 'SplashViewController', pasando el 'viewModel' como dependencia.
        // De esta forma, 'SplashViewController' podrá usar el 'viewModel' para controlar su comportamiento.
        return SplashViewController(viewModel: viewModel)
    }
}
