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
        case let .detail(feedItem):
            var detailFeedModuleInput = assembly.detailFeedModuleInput(feedItem)
            
            guard let viewController = detailFeedModuleInput.viewInput?.viewController else { return }
            
            detailFeedModuleInput.router = self
            assembly.navigationController.pushViewController(viewController, animated: true)
        }
    }
}
