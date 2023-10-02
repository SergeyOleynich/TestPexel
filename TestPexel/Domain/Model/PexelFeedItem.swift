//
//  PexelFeedItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

struct PexelFeedResponseItem {
    let page: Int
    let perPage: Int
    let totalResults: Int
    let nextPage: String?
    let photos: [PexelFeedItem]
}

extension PexelFeedResponseItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case page
        case perPage = "per_page"
        case totalResults = "total_results"
        case nextPage = "next_page"
        case photos
    }
}

struct PexelFeedItem {
    let id: Int
    let photographerName: String
    let src: PexelFeedSrcItem
}

struct PexelFeedSrcItem: Codable {
    let medium: String
}

// MARK: - Codable

extension PexelFeedItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case photographerName = "photographer"
        case src
    }
}

// MARK: - Equatable

extension PexelFeedItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
