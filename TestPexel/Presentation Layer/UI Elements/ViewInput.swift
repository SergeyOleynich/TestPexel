//
//  ViewInput.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIViewController

protocol ViewInput: AnyObject {
    var viewController: UIViewController { get }
}

extension ViewInput where Self: UIViewController {
    var viewController: UIViewController { self }
}
