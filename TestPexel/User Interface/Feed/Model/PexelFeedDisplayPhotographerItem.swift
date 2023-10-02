//
//  PexelFeedDisplayPhotographerItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIView

struct PexelFeedDisplayPhotographerItem: PexelFeedDisplayItem {
    var cellType: UIView.Type { PexelFeedTableViewCell.self }
    
    let title: String
    let imageUrl: URL?
}
