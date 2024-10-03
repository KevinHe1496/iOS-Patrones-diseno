//
//  HeroesListViewModelTests.swift
//  SWPatternsTests
//
//  Created by Kevin Heredia on 2/10/24.
//


import XCTest
@testable import SWPatterns

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

final class HeroesListViewModelTests: XCTest{
    
}

