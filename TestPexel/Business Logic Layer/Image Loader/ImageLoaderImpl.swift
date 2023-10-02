//
//  ImageLoaderImpl.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIImage

final class ImageLoaderImpl: ImageLoader {
    func loadImage(for url: URL, completion: @escaping (UIImage?, URL) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            guard let responseData = data, error == nil, let image = UIImage(data: responseData) else {
                print("Image download error: \(String(describing: error))\nfor url: \(String(describing: response?.url?.absoluteString))")
                DispatchQueue.main.async {
                    completion(nil, response?.url ?? url)
                }
                return
            }
            
            DispatchQueue.main.async {
                completion(image, response?.url ?? url)
            }
        }
        
        dataTask.resume()
    }
}

// MARK: - PexelFeedDisplayPhotographerItemDelegate

extension ImageLoaderImpl: PexelFeedDisplayPhotographerItemDelegate { }
