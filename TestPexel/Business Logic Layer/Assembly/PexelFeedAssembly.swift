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
    
    var feedModuleInput: PexelFeedModuleInput {
        guard let viewController = UIStoryboard(name: "Main", bundle: nil)
            .instantiateViewController(withIdentifier: String(describing: PexelFeedViewController.self)) as? PexelFeedViewController else {
            preconditionFailure()
        }
                
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
        
        return presenter
    }
    
    var detailFeedModuleInput: (DetailFeedDisplayItem) -> PexelDetailFeedModuleInput {
        return { feedItem in
            guard let viewController = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: String(describing: DetailFeedViewController.self)) as? DetailFeedViewController else {
                preconditionFailure()
            }
                                
            let presenter = DetailFeedPresenter(feedItem: feedItem)
            
            viewController.output = presenter
            viewController.imageLoader = injection.pexelDetailFeedInjection.imageLoader
            presenter.viewInput = viewController
            
            return presenter
        }
    }
}
