//
//  PexelFeedPaginator.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

final class PexelFeedPaginator {
    enum State {
        case processing
        case loadMore
        case end
    }
    
    enum Event {
        case didStartLoading
        case didFinishLoading(nextPage: Int?)
    }
    
    weak var delegate: PexelFeedPaginatorDelegate?
    
    private(set) var state: State = .loadMore
}

// MARK: - Public

extension PexelFeedPaginator {
    func apply(event: Event) {
        switch (event, state) {
        case (.didStartLoading, .loadMore):
            self.state = .processing
        
        case let (.didFinishLoading(nextPage), .processing):
            if let nextPage = nextPage {
                self.state = .loadMore
                delegate?.shouldProvideNextPage(nextPage, paginator: self)
            }
            else {
                self.state = .end
                delegate?.didEndPagination(paginator: self)
            }
            
        default: break
        }
    }
}
