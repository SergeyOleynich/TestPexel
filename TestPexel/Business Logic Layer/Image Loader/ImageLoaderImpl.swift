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
                        
            completion(image, response?.url ?? url)
        }
        
        dataTask.resume()
    }
}

final class CachedImageLoaderImpl: ImageLoader {
    private let decoratee: ImageLoader
    private let cache: NSCache<NSString, UIImage> = .init()
    
    init(decoratee: ImageLoader) {
        self.decoratee = decoratee
    }
    
    func loadImage(for url: URL, completion: @escaping (UIImage?, URL) -> Void) {
        if let cachedImage = cache.object(forKey: url.absoluteString as NSString) {
            completion(cachedImage, url)
            return
        }
        
        decoratee.loadImage(for: url) {[weak self] image1, url1 in
            if let image1 = image1 {
                self?.cache.setObject(image1, forKey: url1.absoluteString as NSString)
            }
            
            completion(image1, url1)
        }
    }
}
