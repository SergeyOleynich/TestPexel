//
//  TableItem.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIView

protocol TableItem {
    var cellType: UIView.Type { get }
}
