//
//  PexelFeedDisplayItemProvider.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

protocol PexelFeedDisplayItemProvider {
    var imageLoaderDelegate: PexelFeedDisplayPhotographerItemDelegate? { get set }
    
    func provideDisplayItem(from responseModel: PexelFeedResponsePhotoItem) -> PexelFeedDisplayItem
}

final class PexelFeedDisplayItemProviderImpl: PexelFeedDisplayItemProvider {
    weak var imageLoaderDelegate: PexelFeedDisplayPhotographerItemDelegate?
    
    func provideDisplayItem(from responseModel: PexelFeedResponsePhotoItem) -> PexelFeedDisplayItem {
        var displayItem = PexelFeedDisplayPhotographerItem(
            title: responseModel.photographerName,
            imageUrl: responseModel.src.mediumUrl,
            imageSize: responseModel.size)
        
        displayItem.delegate = imageLoaderDelegate
        
        return displayItem
    }
}
