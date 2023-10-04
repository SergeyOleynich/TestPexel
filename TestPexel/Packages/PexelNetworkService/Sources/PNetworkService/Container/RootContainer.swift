//
//  RootContainer.swift
//  
//
//  Created by Serhii Oleinich on 04.10.2023.
//

import Foundation

public struct RootContainer {
    public var outputService: OutputService { OutputServiceImpl(dependencies: dependencies) }

    private let dependencies: Dependencies

    public init(dependencies: Dependencies) {
        self.dependencies = dependencies
    }
}
