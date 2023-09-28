//
//  PexelFeedViewOutput.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

protocol PexelFeedViewOutput {
    var items: [PexelFeedDisplayItem] { get }
    
    func onViewDidLoad()
}
