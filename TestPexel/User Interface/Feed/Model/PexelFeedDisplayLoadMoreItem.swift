//
//  PexelFeedDisplayLoadMoreItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

struct PexelFeedDisplayLoadMoreItem: PexelFeedDisplayItem {
    var cellType: UIView.Type { PexelFeedLoadMoreTableViewCell.self }
    
    var onNextLoad: () -> Void
}
