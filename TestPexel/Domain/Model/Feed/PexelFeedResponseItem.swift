//
//  PexelFeedResponseItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

struct PexelFeedResponseItem {
    let page: Int
    let perPage: Int
    let totalResults: Int
    let nextPage: String?
    let photos: [PexelFeedResponsePhotoItem]
}

// MARK: - Codable

extension PexelFeedResponseItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case nextPage = "next_page"
        case photos
    }
}
