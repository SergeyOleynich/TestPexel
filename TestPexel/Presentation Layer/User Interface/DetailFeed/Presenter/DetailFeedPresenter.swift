//
//  DetailFeedPresenter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit

final class DetailFeedPresenter: PexelDetailFeedModuleInput {
    weak var viewInput: DetailFeedViewInput?
    var router: PexelFeedRouter?
    
    private let feedItem: DetailFeedDisplayItem
    
    init(feedItem: DetailFeedDisplayItem) {
        self.feedItem = feedItem
    }
}

// MARK: - DetailFeedViewOutput

extension DetailFeedPresenter: DetailFeedViewOutput {
    func onViewDidLoad() {
        viewInput?.didLoad(item: feedItem)
    }
}
