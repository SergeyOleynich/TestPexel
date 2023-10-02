//
//  SceneDelegate.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    private lazy var applicationAssembly: ApplicationAssembly? = {
        return ApplicationAssemblyImpl(mainWindow: window)
    }()
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        applicationAssembly?.applicationCoordinator.start()
        
    }
}

