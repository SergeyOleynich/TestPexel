//
//  PexelFeedPresenter.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

import UIKit.UIImage

final class PexelFeedPresenter {
    weak var viewInput: PexelFeedViewInput?
    
    private var inputDataSource: [PexelFeedDisplayItem] = []
    private let dataProvider: PexelFeedDataProvider
    private let displayItemProvider: PexelFeedDisplayItemProvider
    private let imageLoader: ImageLoader
    
    init(
        dataProvider: PexelFeedDataProvider,
        displayItemProvider: PexelFeedDisplayItemProvider,
        imageLoader: ImageLoader
    ) {
        self.dataProvider = dataProvider
        self.displayItemProvider = displayItemProvider
        self.imageLoader = imageLoader
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

//// MARK: - PexelFeedDisplayPhotographerItemDelegate
//
//extension PexelFeedPresenter: PexelFeedDisplayPhotographerItemDelegate {
//    func loadImage(for url: URL, completion: @escaping (UIImage) -> Void) {
//        DispatchQueue.global(qos: .userInitiated).async {
//            do {
//                let imageData = try Data(contentsOf: url)
//                if let image = UIImage(data: imageData) {
//                    DispatchQueue.main.async {
//                        completion(image)
//                    }
//                }
//            } catch {
//                print("image load error: \(error)")
//            }
//        }
//    }
//}

// MARK: - Private

private extension PexelFeedPresenter {
    func provideData(for page: Int) {
        dataProvider.provideData(for: page) {[weak self] result in
            switch result {
            case let .success(feedResponseItem):
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
