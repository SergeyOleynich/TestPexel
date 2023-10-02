//
//  ImageLoader.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIImage

protocol ImageLoader {
    func loadImage(for url: URL, completion: @escaping (UIImage?, URL) -> Void)
}

