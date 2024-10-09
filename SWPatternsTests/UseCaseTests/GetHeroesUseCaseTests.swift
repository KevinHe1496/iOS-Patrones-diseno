//
//  GetHeroesUseCaseTests.swift
//  SWPatternsTests
//
//  Created by Kevin Heredia on 9/10/24.
//

import Foundation
@testable import SWPatterns
import XCTest

final class GetHeroesUseCaseTests: XCTestCase {
    func testSuccess() {
        guard let mockURL = Bundle(for: type(of: self)).url(forResource: "HeroListMock", withExtension: "json"),
              let data = try? Data(contentsOf: mockURL) else{
            return XCTFail("Mock can't be found")
        }
        
        let sut = GetAllHeroesUseCase()
        let expectation = self.expectation(description: "TestSuccessToken")
        
        APISession.shared = APISessionMock { _ in .success(data) }
        sut.execute { result in
            guard case .success(let heroes) = result else {
                return
            }
            XCTAssertEqual(heroes.count, 23)
            expectation.fulfill()

        }
        waitForExpectations(timeout: 5)
        
    }
    
    func testFailed() {
        let sut = GetAllHeroesUseCase()
        let expectation = self.expectation(description: "TestFailed")
        APISession.shared = APISessionMock { request in
            return .failure(APIErrorReponse.unknown(""))
        }
        
        sut.execute { result in
            guard case .failure = result else {
                return
            }
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
    }
}
