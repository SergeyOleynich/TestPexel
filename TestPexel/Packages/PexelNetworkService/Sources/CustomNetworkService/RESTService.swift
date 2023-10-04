//
//  RestService.swift
//  
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

public struct RESTService {
    private let session: URLSession
    private let responseValidator: ResponseValidator
    
    init(session: URLSession = .shared, responseValidator: ResponseValidator) {
        self.session = session
        self.responseValidator = responseValidator
    }
    
    public init(session: URLSession = .shared) {
        self.session = session
        self.responseValidator = ResponseValidatorComposer(
            validators: [
                HTTPURLResponseValidator(),
                ErrorResponseValidator()
            ])
    }
}

// MARK: - Network Service

extension RESTService: NetworkService {
    public func request<ResponseModel>(
        resource: Resource<ResponseModel>,
        response: @escaping (Result<ResponseModel, Error>) -> Void) {
            session.dataTask(with: resource.urlRequest) { data, urlResponse, error in
                switch Result(catching: { try responseValidator.validate(response: urlResponse, error: error) }) {
                case .success where data != nil:
                    response(resource.decoder(data!))
                    
                case let .failure(error):
                    response(.failure(
                        NetworkServiceError(
                            errorCode: (error as NSError).code,
                            underlayingError: error)))
                    
                default:
                    response(.failure(
                        NetworkServiceError.init(
                            errorCode: NetworkServiceErrorCode.noData.rawValue,
                            underlayingError: nil)))
                }
            }.resume()
    }
}
