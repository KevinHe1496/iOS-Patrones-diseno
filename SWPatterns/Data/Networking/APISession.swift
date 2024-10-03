//
//  APISession.swift
//  SWPatterns
//
//  Created by Kevin Heredia on 1/10/24.
//

import Foundation

protocol APISessionContract {
    // Protocolo que define un contrato para realizar solicitudes a una API.
    // El método request toma un objeto que conforma el protocolo APIRequest
    // y un closure de completion que devuelve un Result con los datos de la respuesta o un error.
    func request<Request: APIRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void)
    
}


struct APISession: APISessionContract {
    static var shared: APISessionContract = APISession()
    
    private let session = URLSession(configuration: .default)
    private let requestInterceptors: [ApiRequestInterceptor]
    
    init(requestInterceptors: [ApiRequestInterceptor] = [AuthenticationRequestInterceptor()]) {
        self.requestInterceptors = requestInterceptors
    }
    
    func request<Request: APIRequest>(apiRequest: Request, completion: @escaping (Result<Data, Error>) -> Void) {
        
        do {
            // esto es la url completa de donde esta el api
            var urlRequest = try apiRequest.getRequest()
            
            
            requestInterceptors.forEach { $0.intercept(request: &urlRequest) }
            
            session.dataTask(with: urlRequest) { data, response, error in
                if let error {
                    return completion(.failure(error))
                }
                
                guard let httResponse = response as? HTTPURLResponse, httResponse.statusCode == 200 else{
                    return completion(.failure(APIErrorReponse.network(apiRequest.path)))
                }
                
                return completion(.success(data ?? Data()))
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }
}
