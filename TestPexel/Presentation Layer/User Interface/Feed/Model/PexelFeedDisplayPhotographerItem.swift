//
//  PexelFeedDisplayPhotographerItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIView
import UIKit.UIImage

protocol PexelFeedDisplayPhotographerItemDelegate: AnyObject {
    func loadImage(for url: URL, in size: CGSize, radius: CGFloat, completion: @escaping (UIImage?, URL) -> Void)
}

struct PexelFeedDisplayPhotographerItem: PexelFeedDisplayItem {
    var cellType: UIView.Type { PexelFeedTableViewCell.self }
    
    let id: String
    let title: String
    let imageUrl: URL?
    let imageSize: CGSize
    
    weak var delegate: PexelFeedDisplayPhotographerItemDelegate?
}
