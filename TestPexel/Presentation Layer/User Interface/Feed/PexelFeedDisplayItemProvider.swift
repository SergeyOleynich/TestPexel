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
    
    func provideDetailDisplayItem(
        for displayModel: PexelFeedDisplayItem,
        from items: [PexelFeedResponsePhotoItem]
    ) -> DetailFeedDisplayItem?
}

final class PexelFeedDisplayItemProviderImpl {
    weak var imageLoaderDelegate: PexelFeedDisplayPhotographerItemDelegate?
}

// MARK: - PexelFeedDisplayItemProvider

extension PexelFeedDisplayItemProviderImpl: PexelFeedDisplayItemProvider {
    func provideDisplayItem(from responseModel: PexelFeedResponsePhotoItem) -> PexelFeedDisplayItem {
        var displayItem = PexelFeedDisplayPhotographerItem(
            id: "\(responseModel.id)",
            title: responseModel.photographerName,
            imageUrl: responseModel.src.mediumUrl,
            imageSize: responseModel.size)
        
        displayItem.delegate = imageLoaderDelegate
        
        return displayItem
    }
    
    func provideDetailDisplayItem(
        for displayModel: PexelFeedDisplayItem,
        from items: [PexelFeedResponsePhotoItem]
    ) -> DetailFeedDisplayItem? {
        guard let photographerItem = displayModel as? PexelFeedDisplayPhotographerItem else { return nil }
        
        return items
            .first(where: { "\($0.id)" == photographerItem.id })
            .map { DetailFeedDisplayItem(
                id: "\($0.id)",
                photographerName: $0.photographerName,
                imageString: $0.src.original)
            }
    }
}
