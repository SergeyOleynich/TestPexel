//
//  OutputService.swift
//  
//
//  Created by Serhii Oleinich on 04.10.2023.
//

import Foundation

public protocol OutputService {
    var networkService: NetworkService { get }
}

final class OutputServiceImpl {
    private let dependencies: Dependencies

    init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}

// MARK: - OutputService

extension OutputServiceImpl: OutputService {
    var networkService: NetworkService {
        guard let urlSession = dependencies.urlSession else {
            return RESTService()
        }
        
        return RESTService(session: urlSession)
    }
}
