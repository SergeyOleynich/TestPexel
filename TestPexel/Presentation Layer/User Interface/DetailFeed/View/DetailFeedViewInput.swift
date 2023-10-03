//
//  DetailFeedViewInput.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

protocol DetailFeedViewInput: ViewInput {
    func didLoad(item: DetailFeedDisplayItem)
}
