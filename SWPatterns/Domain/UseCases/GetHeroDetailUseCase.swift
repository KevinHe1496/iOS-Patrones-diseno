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
    func execute(completion: @escaping (Result<[Hero], Error>) -> Void)
}

// Clase que implementa el protocolo GetHeroDetailUseCaseContract.
final class GetHeroDetailUseCase: GetHeroDetailUseCaseContract {
    // Implementación del método 'execute' que obtendrá detalles del héroe.
    func execute(completion: @escaping (Result<[Hero], any Error>) -> Void) {
        
        // Se crea una instancia de `GetOneHeroDetailAPIRequest` con un nombre vacío.
        // Esto sugiere que se obtendrá el detalle de un héroe específico, pero el nombre debería ser modificado para buscar uno en particular.
        GetHeroesAPIRequest(name: "")
            // Se ejecuta el método `perform` en la solicitud API.
            // Este método acepta un closure que manejará el resultado de la solicitud.
            .perform { result in
                do {
                    // Si la solicitud API es exitosa, se intenta obtener el resultado llamando al método `get()` del `Result`.
                    // Aquí se espera que el resultado contenga un objeto de tipo Hero.
                    try completion(.success(result.get()))
                } catch {
                    // Si ocurre un error al intentar obtener el resultado, se captura el error
                    // y se pasa al closure de completado como un resultado fallido.
                    completion(.failure(error))
                }
            }
    }
}
