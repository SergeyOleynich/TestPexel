//
//  PexelFeedResponseSrcItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

struct PexelFeedResponseSrcItem: Codable {
    let original: String
    let medium: String
}

// MARK: - Computed Properties

extension PexelFeedResponseSrcItem {
    var mediumUrl: URL? { URL(string: medium) }
}
