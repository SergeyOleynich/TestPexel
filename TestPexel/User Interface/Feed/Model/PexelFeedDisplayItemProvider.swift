//
//  PexelFeedDisplayItemProvider.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

protocol PexelFeedDisplayItemProvider {
    func provideDisplayItem(from responseModel: PexelFeedResponsePhotoItem) -> PexelFeedDisplayItem
}

struct PexelFeedDisplayItemProviderImpl: PexelFeedDisplayItemProvider {
    func provideDisplayItem(from responseModel: PexelFeedResponsePhotoItem) -> PexelFeedDisplayItem {
        PexelFeedDisplayPhotographerItem(
            title: responseModel.photographerName,
            imageUrl: responseModel.src.mediumUrl)
    }
}
