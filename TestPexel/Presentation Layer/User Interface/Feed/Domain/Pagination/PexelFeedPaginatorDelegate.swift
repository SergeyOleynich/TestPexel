//
//  PexelFeedPaginatorDelegate.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

protocol PexelFeedPaginatorDelegate: AnyObject {
    func didEndPagination(paginator: PexelFeedPaginator)
    func shouldProvideNextPage(_ page: Int, paginator: PexelFeedPaginator)
}
