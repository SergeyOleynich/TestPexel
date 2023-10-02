//
//  ApplicationCoordinator.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UINavigationController

struct ApplicationCoordinator {
    let assembly: ApplicationAssembly
    
    init(assembly: ApplicationAssembly) {
        self.assembly = assembly
    }
    
    func start() {
        assembly.mainWindow?.rootViewController = UINavigationController()
        assembly.mainWindow?.makeKeyAndVisible()
        
        assembly.feedCoordinator.start()
    }
}
