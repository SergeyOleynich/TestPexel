//
//  PexelDetailFeedModuleInput.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

protocol PexelDetailFeedModuleInput {
    var viewInput: DetailFeedViewInput? { get set }
    var router: PexelFeedRouter? { get set }
}
