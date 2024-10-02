
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
    private let useCase: LoginUseCaseContract
    
    init(useCase: LoginUseCaseContract) {
        self.useCase = useCase
    }
    
    func signIn(_ username: String?, _ password: String?){
        
        
        // 3. Si ambos son válidos, actualizamos el estado a 'loading' (cargando).
        onStateChanged.update(newValue: .loading)
        let credentials = Credentials(username: username ?? "", password: password ?? "")
        useCase.execute(credentials: credentials) { [weak self] result in
            do {
                // el .get Devuelve el valor de success
                try result.get()
                // si todo sale bien cambiamos el valor
                self?.onStateChanged.update(newValue: .success)
            } catch let error as LoginUseCaseError {
                self?.onStateChanged.update(newValue: .error(reason: error.reason))
            } catch {
                self?.onStateChanged.update(newValue: .error(reason: "Something has happened"))
            }
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 3){ [weak self] in
            // Después del retraso, actualizamos el estado a 'success' (login exitoso).
            self?.onStateChanged.update(newValue: .success)
            
        }
    }
    
    
}
