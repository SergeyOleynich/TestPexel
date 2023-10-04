//
//  PexelFeedAssembly.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UINavigationController

struct PexelFeedAssembly {
    let navigationController: UINavigationController
    private let injection: PexelFeedInjection
    
    init(injection: PexelFeedInjection, navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.injection = injection
    }
    
    var feedModuleInput: (viewController: UIViewController, moduleInput: PexelFeedModuleInput) {
        let viewController = PexelFeedViewController()
        
        let imageLoader = injection.imageLoader
        var displayItemProvider = injection.displayItemProvider
        let paginatorStateProvider = injection.paginatorStateProvider
        let dataProvider = injection.dataProvider
        
        let presenter = PexelFeedPresenter(
            dataProvider: dataProvider,
            displayItemProvider: displayItemProvider,
            feedImageLoader: imageLoader)
        
        displayItemProvider.imageLoaderDelegate = imageLoader
        paginatorStateProvider.delegate = presenter
        
        viewController.output = presenter
        presenter.viewInput = viewController
        
        return (viewController, presenter)
    }
    
    var detailFeedModuleInput: (viewController: UIViewController, moduleInput: PexelDetailFeedModuleInput) {
        let viewController = DetailFeedViewController()
        let presenter = DetailFeedPresenter()
        
        viewController.output = presenter
        viewController.imageLoader = injection.pexelDetailFeedInjection.imageLoader
        presenter.viewInput = viewController
        
        return (viewController, presenter)
    }
}
