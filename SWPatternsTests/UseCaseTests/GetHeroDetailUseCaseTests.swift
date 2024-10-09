//
//  GetHeroDetailUseCaseTests.swift
//  SWPatternsTests
//
//  Created by Kevin Heredia on 9/10/24.
//

import Foundation
import XCTest
@testable import SWPatterns

final class GetHeroDetailUseCaseTests: XCTestCase {
    func testSuccess() {
        guard let mockURL = Bundle(for: type(of: self)).url(forResource: "GetHeroDetailMock", withExtension: "json"),
              let data = try? Data(contentsOf: mockURL) else{
            return XCTFail("Mock can't be found")
        }
        let sut = GetHeroDetailUseCase()
        let expectation = self.expectation(description: "TestSuccessToken")
        
        APISession.shared = APISessionMock { _ in .success(data) }
        sut.execute(name: "Goku") { result in
            guard case .success(let hero) = result else {
                return
            }
            
            XCTAssertEqual(hero.name, "Goku")
            XCTAssertEqual(hero.identifier, "D13A40E5-4418-4223-9CE6-D2F9A28EBE94")
            XCTAssertEqual(hero.description, "Sobran las presentaciones cuando se habla de Goku. El Saiyan fue enviado al planeta Tierra, pero hay dos versiones sobre el origen del personaje. Según una publicación especial, cuando Goku nació midieron su poder y apenas llegaba a dos unidades, siendo el Saiyan más débil. Aun así se pensaba que le bastaría para conquistar el planeta. Sin embargo, la versión más popular es que Freezer era una amenaza para su planeta natal y antes de que fuera destruido, se envió a Goku en una incubadora para salvarle.")
            XCTAssertEqual(hero.photo, "https://cdn.alfabetajuega.com/alfabetajuega/2020/12/goku1.jpg?width=300")
            XCTAssertFalse(hero.favorite)
            expectation.fulfill()

        }
        waitForExpectations(timeout: 5)
    }
    
    
    func testFailed() {
        let sut = GetHeroDetailUseCase()
        let expectation = self.expectation(description: "TestFailed")
        
        APISession.shared = APISessionMock { request in
            return .failure(APIErrorReponse.unknown(""))
        }
        
        sut.execute(name: "Krilin") { result in
            guard case .failure = result else {
                return
            }
            expectation.fulfill()

        }
        waitForExpectations(timeout: 5)
    }
}
