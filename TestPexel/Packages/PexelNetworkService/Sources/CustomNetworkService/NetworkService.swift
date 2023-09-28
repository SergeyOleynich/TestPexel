//
//  NetworkService.swift
//  
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

public protocol NetworkService {
    func request<ResponseModel>(
        resource: Resource<ResponseModel>,
        response: @escaping (Result<ResponseModel, Error>) -> Void)
}

public struct NetworkServiceError: Error {
    public let domain: String = "Network"
    public let errorCode: Int
    
    public let underlayingError: Error?
}

public enum NetworkServiceErrorCode: Int {
    case noData
}
