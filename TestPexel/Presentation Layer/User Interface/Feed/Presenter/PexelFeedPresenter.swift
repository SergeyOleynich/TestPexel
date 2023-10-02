//
//  PexelFeedPresenter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

protocol PexelFeedRouter {
    func navigate(to action: PexelFeedCoordinatorNavigationAction)
}

enum PexelFeedCoordinatorNavigationAction {
    case detail(id: String)
}

final class PexelFeedPresenter: PexelFeedModuleInput {
    weak var viewInput: PexelFeedViewInput?
    var router: PexelFeedRouter?
    
    private var test: [PexelFeedResponsePhotoItem] = []
    private var inputDataSource: [PexelFeedDisplayItem] = []
    private let dataProvider: PexelFeedDataProvider
    private let displayItemProvider: PexelFeedDisplayItemProvider
    private let feedImageLoader: PexelFeedImageLoader
    
    init(
        dataProvider: PexelFeedDataProvider,
        displayItemProvider: PexelFeedDisplayItemProvider,
        feedImageLoader: PexelFeedImageLoader
    ) {
        self.dataProvider = dataProvider
        self.displayItemProvider = displayItemProvider
        self.feedImageLoader = feedImageLoader
    }
}

// MARK: - PexelFeedViewOutput

extension PexelFeedPresenter: PexelFeedViewOutput {
    var items: [PexelFeedDisplayItem] { inputDataSource }
    
    func onViewDidLoad() {
        provideData(for: 1)
    }
    
    func onSelected(item: PexelFeedDisplayItem) {
        router?.navigate(to: .detail(id: item.id))
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
            case let .success(feedResponseItem):
                dispatchPrecondition(condition: .notOnQueue(.main))
                
                let loadMoreIndex = self?.inputDataSource.firstIndex(where: { $0 is PexelFeedDisplayLoadMoreItem }) ?? 0
                
                let displayItems = feedResponseItem.photos.compactMap { self?.displayItemProvider.provideDisplayItem(from: $0) }
                
                self?.inputDataSource.insert(contentsOf: displayItems, at: loadMoreIndex)
                
                self?.viewInput?.didLoadItems()
                
            case let .failure(failure):
                print(failure)
            }
        }
    }
}
