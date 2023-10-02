//
//  PexelFeedImageLoaderImpl.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIImage

final class PexelFeedImageLoaderImpl: PexelFeedImageLoader {
    private let decoratee: ImageLoader
    private lazy var operationQueue: OperationQueue = {
        let operation = OperationQueue()
        operation.name = "com.pexel.imageProcessing"
        operation.qualityOfService = .userInitiated
        
        return operation
    }()
    
    init(decoratee: ImageLoader) {
        self.decoratee = decoratee
    }
}

extension PexelFeedImageLoaderImpl {
    func loadImage(for url: URL, in size: CGSize, radius: CGFloat, completion: @escaping (UIImage?, URL) -> Void) {
        decoratee.loadImage(for: url) {[weak self] image, imageUrl in
            switch image {
            case let .some(image):
                self?.operationQueue.addOperation {
                    let modifiedImage = image
                        .crop(to: size)
                        .round(radius)
                    
                    completion(modifiedImage, imageUrl)
                }
                
            case .none:
                completion(image, imageUrl)
            }
        }
    }
}
