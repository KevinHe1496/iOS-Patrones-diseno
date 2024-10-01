
import Foundation

enum LoginState{
    case success // Estado cuando el login es exitoso.
    case error(reason: String) // Estado cuando ocurre un error, con una razón específica.
    case loading   // Estado mientras el login está en proceso (cargando).
    
}

// ViewModel que maneja la lógica del login.
final class LoginViewModel {
    // Propiedad que utiliza la clase Binding para notificar los cambios de estado.
    let onStateChanged = Binding<LoginState>()
    
    func signIn(_ username: String?, _ password: String?){
        // 1. Validamos que el nombre de usuario no sea nulo y sea válido.
        guard let username, validateUsername(username) else{
            return onStateChanged.update(newValue: .error(reason: "Invalid username"))
        }
        // 2. Validamos que la contraseña no sea nula y sea válida.
        guard let password, validatePassword(password) else{
            return onStateChanged.update(newValue: .error(reason: "invalid password"))
        }
        
        // 3. Si ambos son válidos, actualizamos el estado a 'loading' (cargando).
        onStateChanged.update(newValue: .loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3){ [weak self] in
            // Después del retraso, actualizamos el estado a 'success' (login exitoso).
            self?.onStateChanged.update(newValue: .success)
            
        }
    }
    
    // Validación básica para el nombre de usuario (debe contener un "@" y no estar vacío).
    private func validateUsername(_ username: String) -> Bool {
        username.contains("@") && !username.isEmpty
    }
    
    // Validación básica para la contraseña (debe tener al menos 4 caracteres).
    private func validatePassword(_ password: String) -> Bool {
        password.count >= 4
    }
}
