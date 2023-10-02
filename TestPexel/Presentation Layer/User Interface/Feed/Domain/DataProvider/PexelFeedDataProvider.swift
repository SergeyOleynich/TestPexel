//
//  PexelFeedDataProvider.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 01.10.2023.
//

import Foundation

protocol PexelFeedDataProvider {
    func provideData(
        for page: Int,
        completion: @escaping ((Result<PexelFeedResponseItem, Error>) -> Void))
}
