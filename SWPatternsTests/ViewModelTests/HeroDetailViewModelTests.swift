//
//  HeroDetailViewModelTests.swift
//  SWPatternsTests
//
//  Created by Kevin Heredia on 4/10/24.
//

@testable import SWPatterns
import XCTest


private final class SuccessGetHeroDetailUseCaseMock: GetHeroDetailUseCaseContract {
    // Mock para el caso de exito
    func execute(completion: @escaping (Result<Hero, any Error>) -> Void) {
        // Simula una ejecución exitosa de la obtención de detalles de un héroe.
        // En este caso, devuelve un héroe con los detalles especificados.
        completion(.success(Hero(identifier: "123", name: "Goku", description: "", photo: "", favorite: false)))
    }
}



// Mock para el caso de fallo
private final class FailedGetHeroDetailUseCaseMock: GetHeroDetailUseCaseContract {
    
    func execute(completion: @escaping (Result<Hero, any Error>) -> Void) {
        // Simula una ejecución fallida.
        // Devuelve un error personalizado en lugar de un héroe.
        completion(.failure(APIErrorReponse.unknown("")))
    }
}


final class HeroDetailViewModelTests: XCTestCase {
    
    func testSuccessScenario() {
        // Crea expectativas que deben cumplirse durante la prueba.
        let successExpectation = expectation(description: "Success")
        let loadingExpectation = expectation(description: "Loading")
        
        // Utiliza el mock para el caso de éxito.
        let useCaseMock = SuccessGetHeroDetailUseCaseMock()
        
        // Crea una instancia del ViewModel que va a ser probado.
        let sut = HeroDetailViewModel(useCase: useCaseMock)
        
        // Vincula la propiedad 'onStateChange' para verificar los estados de la vista.
        sut.onStateChange.bind { state in
            if state == .loading {
                // Si el estado es 'loading', se cumple la expectativa correspondiente.
                loadingExpectation.fulfill()
            } else if state == .success {
                // Si el estado es 'success', se cumple la expectativa de éxito.
                successExpectation.fulfill()
            }
        }
        
        // Llama al método 'load' que debería cargar el héroe.
        sut.load()
        
        // Espera hasta 5 segundos para que las expectativas se cumplan.
        waitForExpectations(timeout: 5)
        
        // Verifica que el héroe cargado tenga el nombre y el identificador correcto.
        XCTAssertEqual(sut.hero?.name , "Goku")
        XCTAssertEqual(sut.hero?.identifier, "123")
    }
    
    
    func testFailScenario(){
        // Expectativa de que ocurra un error.
        let errorExpectation = expectation(description: "Error")
        // Expectativa de que se esté cargando.
        let loadingExpectation = expectation(description: "Loading")
        
        // Utiliza el mock para el caso de fallo.
        let useCaseMock = FailedGetHeroDetailUseCaseMock()
        
        // Crea una instancia del ViewModel que va a ser probado.
        let sut = HeroDetailViewModel(useCase: useCaseMock)
        
        // Vincula la propiedad 'onStateChange' para verificar los estados de la vista.
        sut.onStateChange.bind { state in
            if state == .loading {
                // Si el estado es 'loading', se cumple la expectativa correspondiente.
                loadingExpectation.fulfill()
            } else if case .error = state {
                // Si el estado es 'error', se cumple la expectativa de error.
                errorExpectation.fulfill()
            }
        }
        
        // Llama al método 'load' que debería intentar cargar el héroe pero fallará.
        sut.load()
        
        // Espera hasta 5 segundos para que las expectativas se cumplan.
        waitForExpectations(timeout: 5)
        
        // Verifica que no se haya cargado ningún héroe (es decir, que sea nil).
        XCTAssertNil(sut.hero)
    }
    
    
}
