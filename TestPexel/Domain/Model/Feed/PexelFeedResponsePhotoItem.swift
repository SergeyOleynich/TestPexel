//
//  PexelFeedResponsePhotoItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

struct PexelFeedResponsePhotoItem {
    let id: Int
    let width: Int
    let height: Int
    let photographerName: String
    let src: PexelFeedResponseSrcItem
}

// MARK: - Computed Properties

extension PexelFeedResponsePhotoItem {
    var size: CGSize { .init(width: width, height: height) }
}

// MARK: - Codable

extension PexelFeedResponsePhotoItem: Codable {
    private enum CodingKeys: String, CodingKey {
        case id
        case photographerName = "photographer"
        case src
        case width
        case height
    }
}

// MARK: - Equatable

extension PexelFeedResponsePhotoItem: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}
