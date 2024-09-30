
import Foundation

enum LoginState{
    case success
    case error(reason: String)
    case loading
    
}
final class LoginViewModel {
    
    let onStateChanged = Binding<LoginState>()
    func signIn(_ username: String?, _ password: String?){
        guard let username, validateUsername(username) else{
            return onStateChanged.update(newValue: .error(reason: "Invalid username"))
        }
        
        guard let password, validatePassword(password) else{
            return onStateChanged.update(newValue: .error(reason: "invalid password"))
        }
        // 1. Valido username valido
        // 2. Valido password valida
        // 3. Hago login
        onStateChanged.update(newValue: .loading)
        DispatchQueue.global().asyncAfter(deadline: .now() + 3){ [weak self] in
            self?.onStateChanged.update(newValue: .success)
            
        }
    }
    
    private func validateUsername(_ username: String) -> Bool{
        username.contains("@") && !username.isEmpty
    }
    
    private func validatePassword(_ password: String) -> Bool{
        password.count >= 4
    }
}
