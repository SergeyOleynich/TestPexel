//
//  PexelFeedCoordinator.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

protocol FeedCoordinator {
    func start()
}

final class FeedCoordinatorImpl: FeedCoordinator {
    private let assembly: PexelFeedAssembly
    
    init(assembly: PexelFeedAssembly) {
        self.assembly = assembly
    }
    
    func start() {
        guard let viewController = assembly.feedModuleInput.viewInput?.viewController else { return }
        
        assembly.navigationController.pushViewController(viewController, animated: true)
    }
}
