//
//  PexelFeedRouter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 04.10.2023.
//

import Foundation

protocol PexelFeedRouter {
    func navigate(to action: PexelFeedCoordinatorNavigationAction)
}

// MARK: - Action

enum PexelFeedCoordinatorNavigationAction {
    case detail(displayItem: DetailFeedDisplayItem)
}
