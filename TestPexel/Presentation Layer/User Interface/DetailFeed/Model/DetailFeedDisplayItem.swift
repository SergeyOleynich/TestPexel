//
//  DetailFeedDisplayItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

struct DetailFeedDisplayItem {
    let id: String
    
    let photographerName: String
    let imageString: String
}

// MARK: - Computed Properties

extension DetailFeedDisplayItem {
    var imageUrl: URL? { URL(string: imageString) }
}
