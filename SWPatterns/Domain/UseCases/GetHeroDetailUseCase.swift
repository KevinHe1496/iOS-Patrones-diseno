//
//  GetHeroDetailUseCase.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 4/10/24.
//

import Foundation

// Define un protocolo que establece un contrato para obtener detalles de un héroe.
protocol GetHeroDetailUseCaseContract {
    // Método que debe ser implementado para ejecutar la obtención de detalles del héroe.
    // Utiliza un closure como parámetro que devuelve un resultado de tipo Hero o un error.
    func execute(name: String, completion: @escaping (Result<Hero, Error>) -> Void)
}

final class GetHeroDetailUseCase: GetHeroDetailUseCaseContract {
    func execute(name: String, completion: @escaping (Result<Hero, any Error>) -> Void) {
        
        // Se hace la solicitud para obtener un héroe.
        GetHeroesAPIRequest(name: name)
            .perform { result in
                do {
                    // Obtenemos el array de héroes del resultado.
                    let heroes = try result.get()
                    
                    // Verificamos si el array tiene al menos un héroe.
                    if let hero = heroes.first {
                        // Devolvemos el primer héroe como éxito.
                        completion(.success(hero))
                    } else {
                        // Si no hay héroes, devolvemos un error personalizado.
                        completion(.failure(APIErrorReponse.unknown("")))
                    }
                } catch {
                    // Si ocurre un error, lo devolvemos en el closure.
                    completion(.failure(error))
                }
            }
    }
}
