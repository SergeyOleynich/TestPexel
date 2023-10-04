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

final class FeedCoordinatorImpl {
    private let assembly: PexelFeedAssembly
    
    init(assembly: PexelFeedAssembly) {
        self.assembly = assembly
    }
}

// MARK: - FeedCoordinator

extension FeedCoordinatorImpl: FeedCoordinator {
    func start() {
        var moduleInput = assembly.feedModuleInput
        moduleInput.moduleInput.router = self
        assembly.navigationController.pushViewController(moduleInput.viewController, animated: true)
    }
}

// MARK: - PexelFeedRouter

extension FeedCoordinatorImpl: PexelFeedRouter {
    func navigate(to action: PexelFeedCoordinatorNavigationAction) {
        switch action {
        case let .detail(feedItem):
            var moduleInput = assembly.detailFeedModuleInput
            moduleInput.moduleInput.router = self
            moduleInput.moduleInput.item = feedItem
            assembly.navigationController.pushViewController(moduleInput.viewController, animated: true)
        }
    }
}
