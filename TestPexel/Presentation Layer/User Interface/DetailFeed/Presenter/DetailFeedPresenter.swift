//
//  DetailFeedPresenter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

final class DetailFeedPresenter: PexelDetailFeedModuleInput {
    weak var viewInput: DetailFeedViewInput?
    var router: PexelFeedRouter?
    var item: DetailFeedDisplayItem?
}

// MARK: - DetailFeedViewOutput

extension DetailFeedPresenter: DetailFeedViewOutput {
    func onViewDidLoad() {
        guard let item = item else { return }
        viewInput?.didLoad(item: item)
    }
}
