//
//  Resource.swift
//  
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

public struct Resource<ResponseModel> where ResponseModel: Decodable {
    let urlRequest: URLRequest
    let decoder: (Data) -> Result<ResponseModel, Error>
    
    public init(urlRequest: URLRequest, decoder: @escaping (Data) -> Result<ResponseModel, Error>) {
        self.urlRequest = urlRequest
        self.decoder = decoder
    }
}

// MARK: - Default JSONDecoder

extension Resource {
    public init(urlRequest: URLRequest) {
        self.urlRequest = urlRequest
        
        self.decoder = { data -> Result<ResponseModel, Error> in
            Result { try JSONDecoder().decode(ResponseModel.self, from: data) }
        }
    }
}
