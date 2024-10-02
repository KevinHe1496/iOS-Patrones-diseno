//
//  LoginUseCase.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 1/10/24.
//

import Foundation


protocol LoginUseCaseContract {
    
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void)
    
}

final class LoginUseCase: LoginUseCaseContract {
    func execute(credentials: Credentials, completion: @escaping (Result<Void, LoginUseCaseError>) -> Void) {
        
        // 1. Validamos que el nombre de usuario no sea nulo y sea válido.
        guard validateUsername(credentials.username) else{
            return completion(.failure(LoginUseCaseError(reason: "Invalid username")))
            
        }
        // 2. Validamos que la contraseña no sea nula y sea válida.
        guard validatePassword(credentials.password) else{
            return completion(.failure(LoginUseCaseError(reason: "Invalid password")))
        }
        DispatchQueue.global().asyncAfter(deadline: .now() + 10) {
            completion(.success(()))
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

struct LoginUseCaseError: Error {
    let reason: String
}
