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
        var moduleInput = assembly.feedModuleInput
        
        guard let viewController = moduleInput.viewInput?.viewController else { return }
        
        moduleInput.router = self
        assembly.navigationController.pushViewController(viewController, animated: true)
    }
}

extension FeedCoordinatorImpl: PexelFeedRouter {
    func navigate(to action: PexelFeedCoordinatorNavigationAction) {
        switch action {
        case .detail(let id):
            guard let viewController = assembly.detailFeedModuleInput.viewInput?.viewController else { return }
            assembly.navigationController.pushViewController(viewController, animated: true)
        }
    }
}
