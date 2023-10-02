//
//  PexelFeedDisplayItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import Foundation
import UIKit.UIView

protocol PexelFeedDisplayItem: TableItem {
    var cellType: UIView.Type { get }

    var id: String { get }
}
