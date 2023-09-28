//
//  PexelFeedViewOutput.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation

protocol PexelFeedViewOutput {
    var items: [Int] { get }
    
    func onViewDidLoad()
}
