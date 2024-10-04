//
//  LoginUseCaseTest.swift
//  SWPatternsTests
//
//  Created by Kevin Heredia on 3/10/24.
//

import XCTest
@testable import SWPatterns


final class APISessionMock: APISessionContract{
    
    let mockResponse: ((any APIRequest)) -> Result<Data, any Error>
    
    init(mockResponse: @escaping (any APIRequest) -> Result<Data, any Error>) {
        self.mockResponse = mockResponse
    }
    
    func request<Request: APIRequest>(apiRequest: Request, completion: @escaping (Result<Data, any Error>) -> Void) {
        completion(mockResponse(apiRequest))
    }
}

final class DummySessionDataSource: SessionDataSourceContract{
    private(set) var session: Data?
    
    func storeSession(_ session: Data) {
        self.session = session
    }
    
    func getSession() -> Data? {
        nil
    }
    
    
}

final class LoginUseCaseTest: XCTestCase {
    func testSucessStoresToken(){
        let dataSource = DummySessionDataSource()
        let sut = LoginUseCase(dataSource: dataSource)
        
        let expectation = self.expectation(description: "TestSuccess")
        let data = Data("hello-world".utf8)
        
        APISession.shared = APISessionMock { _ in .success(data) }
        sut.execute(credentials: Credentials(username: "a@b.es", password: "12345")) { result in
            guard case .success = result else {
                return
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 5)
        XCTAssertEqual(dataSource.session, data)
    }
}
