//
//  APIInterceptor.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 2/10/24.
//

import Foundation


protocol APIInterceptor {

}


protocol ApiRequestInterceptor: APIInterceptor {
    func intercept(request: inout URLRequest)
}


final class AuthenticationRequestInterceptor: ApiRequestInterceptor {
    private let dataSource: SessionDataSourceContract
    
    init(dataSource: SessionDataSourceContract = SessionDataSource()) {
        self.dataSource = dataSource
    }
    
    func intercept(request: inout URLRequest) {
        guard let session = dataSource.getSession() else{
            return
        }
        request.setValue("Bearer \(String(decoding: session, as: UTF8.self))", forHTTPHeaderField: "Authorization")
    }
}
