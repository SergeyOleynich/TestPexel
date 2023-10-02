//
//  PexelFeedPresenter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

final class PexelFeedPresenter {
    weak var viewInput: PexelFeedViewInput?
    
    private var inputDataSource: [PexelFeedDisplayItem] = []
    private let dataProvider: PexelFeedDataProvider
    
    init(dataProvider: PexelFeedDataProvider) {
        self.dataProvider = dataProvider
    }
}

// MARK: - PexelFeedViewOutput

extension PexelFeedPresenter: PexelFeedViewOutput {
    var items: [PexelFeedDisplayItem] { inputDataSource }
    
    func onViewDidLoad() {
        provideData(for: 1)
    }
}

// MARK: - PexelFeedPaginatorDelegate

extension PexelFeedPresenter: PexelFeedPaginatorDelegate {
    func didEndPagination(paginator: PexelFeedPaginator) {
        _ = inputDataSource.popLast()
    }
    
    func shouldProvideNextPage(_ page: Int, paginator: PexelFeedPaginator) {
        _ = inputDataSource.popLast()
        
        inputDataSource.append(
            PexelFeedDisplayLoadMoreItem() {[weak self] in
                self?.provideData(for: page)
            }
        )
    }
}

// MARK: - Private

private extension PexelFeedPresenter {
    func provideData(for page: Int) {
        dataProvider.provideData(for: page) {[weak self] result in
            switch result {
            case let .success(feedModel):
                let loadMoreIndex = self?.inputDataSource.firstIndex(where: { $0 is PexelFeedDisplayLoadMoreItem }) ?? 0
                
                self?.inputDataSource.insert(contentsOf: feedModel.photos
                    .map { PexelFeedDisplayPhotographerItem.init(
                        title: $0.photographerName,
                        imageUrl: URL(string: $0.src.medium)!) }, at: loadMoreIndex)
                
                self?.viewInput?.didLoadItems()
                
            case let .failure(failure):
                print(failure)
            }
        }
    }
}
