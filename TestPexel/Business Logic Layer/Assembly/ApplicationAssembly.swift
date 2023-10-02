//
//  ApplicationAssembly.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIWindow
import UIKit.UINavigationController

protocol ApplicationAssembly {
    var mainWindow: UIWindow? { get }
    
    var applicationCoordinator: ApplicationCoordinator { get }
    var feedCoordinator: FeedCoordinator { get }
}

struct ApplicationAssemblyImpl: ApplicationAssembly {
    private(set) weak var mainWindow: UIWindow?
    
    init(mainWindow: UIWindow?) {
        self.mainWindow = mainWindow
    }
    
    var applicationCoordinator: ApplicationCoordinator { ApplicationCoordinator(assembly: self) }
    
    var feedCoordinator: FeedCoordinator {
        guard let navigationController = mainWindow?.rootViewController as? UINavigationController else {
            preconditionFailure()
        }
        
        let assembly = PexelFeedAssembly(
            injection: PexelFeedInjectionImpl(),
            navigationController: navigationController)
        return FeedCoordinatorImpl(assembly: assembly)
    }
}
