//
//  HeroesListViewModelTests.swift
//  SWPatternsTests
//
//  Created by Kevin Heredia on 2/10/24.
//



@testable import SWPatterns
import XCTest

private final class SuccessGetHeroesUseCaseMock: GetAllHeroesUseCaseContract{
    func execute(completion: @escaping (Result<[SWPatterns.Hero], any Error>) -> Void) {
        completion(.success([Hero(identifier: "1234",
                                  name: "potato",
                                  description: "",
                                  photo: "",
                                  favorite: false)]))
    }
    
}


private final class FailedGetHeroesUseCaseMock: GetAllHeroesUseCaseContract{
    func execute(completion: @escaping (Result<[SWPatterns.Hero], any Error>) -> Void) {
        completion(.failure(APIErrorReponse.unknown("")))
    }
}

final class HeroesListViewModelTests: XCTestCase{
    
    func testSuccessScenario() {
        
        let successExpectation = expectation(description: "Success")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = SuccessGetHeroesUseCaseMock()
        let sut = HeroesListViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if state == .success {
                successExpectation.fulfill()
            }
        }
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.heroes.count, 1)
    }
    
    
    func testFailScenario() {
        
        let successExpectation = expectation(description: "Success")
        let loadingExpectation = expectation(description: "Loading")
        let useCaseMock = FailedGetHeroesUseCaseMock()
        let sut = HeroesListViewModel(useCase: useCaseMock)
        
        sut.onStateChanged.bind { state in
            if state == .loading {
                loadingExpectation.fulfill()
            } else if case .error = state {
                successExpectation.fulfill()
            }
        }
        
        sut.load()
        waitForExpectations(timeout: 5)
        XCTAssertEqual(sut.heroes.count, 0)
    }
    
}

