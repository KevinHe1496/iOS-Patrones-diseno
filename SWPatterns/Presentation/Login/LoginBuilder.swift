import UIKit

// Clase que se encarga de construir la vista de login y su ViewModel.
final class LoginBuilder {

    // Método que construye la vista de login.
    func build() -> UIViewController {
        // Creamos una instancia del ViewModel de login.
        let viewModel = LoginViewModel()

        // Creamos una instancia del controlador de la vista de login y le pasamos el ViewModel.
        let viewController = LoginViewController(viewModel: viewModel)

        // Configuramos el estilo de presentación para que sea en pantalla completa.
        viewController.modalPresentationStyle = .fullScreen

        // Devolvemos la vista configurada.
        return viewController
    }
}
