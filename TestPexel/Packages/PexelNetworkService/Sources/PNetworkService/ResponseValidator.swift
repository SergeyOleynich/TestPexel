//
//  ResponseValidator.swift
//  
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

protocol ResponseValidator {
    func validate(response: URLResponse?, error: Error?) throws
}

struct ResponseValidatorComposer: ResponseValidator {
    private var validators: [ResponseValidator]
    
    init(validators: [ResponseValidator]) {
        self.validators = validators
    }
    
    func validate(response: URLResponse?, error: Error?) throws {
        try validators
            .forEach { try $0.validate(response: response, error: error) }
    }
}

struct HTTPURLResponseValidator: ResponseValidator {
    func validate(response: URLResponse?, error: Error?) throws {
        guard let httpResponse = response as? HTTPURLResponse else { return }
        
        switch httpResponse.statusCode {
        case (200...300):
            return
            
        default:
            throw URLError(.init(rawValue: httpResponse.statusCode))
        }
    }
}

struct ErrorResponseValidator: ResponseValidator {
    func validate(response: URLResponse?, error: Error?) throws {
        if let error = error {
            throw error
        }
    }
}
