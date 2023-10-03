//
//  ImageLoaderImpl.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIImage

final class ImageLoaderImpl: ImageLoader {
    private static var dataTaskMap: [URL: URLSessionDataTask] = [:]
    
    func loadImage(for url: URL, completion: @escaping (UIImage?, URL) -> Void) {
        let dataTask = URLSession.shared.dataTask(with: .init(url: url)) { data, response, error in
            ImageLoaderImpl.dataTaskMap.removeValue(forKey: url)
            
            guard let responseData = data, error == nil, let image = UIImage(data: responseData) else {
                print("Image download error: \(String(describing: error))\nfor url: \(String(describing: response?.url?.absoluteString))")
                DispatchQueue.main.async {
                    completion(nil, response?.url ?? url)
                }
                return
            }
                        
            completion(image, response?.url ?? url)
        }
        
        ImageLoaderImpl.dataTaskMap[url] = dataTask
        dataTask.resume()
    }
    
    func cancelLoading(for url: URL) {
        ImageLoaderImpl.dataTaskMap[url]?.cancel()
        ImageLoaderImpl.dataTaskMap.removeValue(forKey: url)
    }
}

final class CachedImageLoaderImpl: ImageLoader {
    private let decoratee: ImageLoader
    private let fileManager: FileManager = .default
    private let operationQueue: OperationQueue
    
    private var cachedDirectoryUrl: URL? {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask).first
    }
    
    init(decoratee: ImageLoader) {
        self.decoratee = decoratee
        
        self.operationQueue = OperationQueue()
        operationQueue.name = "com.pexel.cachedImageLoader"
        operationQueue.qualityOfService = .userInitiated
    }
    
    func loadImage(for url: URL, completion: @escaping (UIImage?, URL) -> Void) {
        let cachedPath: String? = {
            guard let cachedDirectoryUrl = cachedDirectoryUrl else { return nil }
            
            let er = getQueryStringParameter(url: url.absoluteString) ?? ""
            let pathExtension = url.pathExtension
            let path = cachedDirectoryUrl.path + "/" + "\(url.deletingPathExtension().lastPathComponent)" + er + ".\(pathExtension)"
            
            return path
        }()
        
        if let cachedPath = cachedPath, fileManager.fileExists(atPath: cachedPath) {
            operationQueue.addOperation {[weak self] in
                if let imageData = try? Data(contentsOf: URL(fileURLWithPath: cachedPath)) {
                    let image = UIImage(data: imageData)
                    completion(image, url)
                }
                else {
                    do {
                        try self?.fileManager.removeItem(atPath: cachedPath)
                        self?.loadImage(for: url, completion: completion)
                    } catch {
                        print("cannot remo item at path \(error)")
                    }
                }
            }
            return
        }
        
        decoratee.loadImage(for: url) {[weak self] image, imageUrl in
            if let cachedPath = cachedPath, cachedPath.isEmpty == false, let imageData = image?.pngData() {
                self?.operationQueue.addOperation {
                    self?.fileManager.createFile(atPath: cachedPath, contents: imageData)
                }
            }
            
            completion(image, imageUrl)
        }
    }
    
    func cancelLoading(for url: URL) { }
}

func getQueryStringParameter(url: String) -> String? {
  guard let url = URLComponents(string: url) else { return nil }
    
   return url.queryItems?
        .sorted(by: { $0.name < $1.name })
        .reduce(into: String(), { partialResult, item in
       partialResult.append(item.name)
       if let itemValue = item.value {
           partialResult.append("=")
           partialResult.append(itemValue)
       }
       partialResult.append("&")
   }).trimmingCharacters(in: CharacterSet(arrayLiteral: "&"))

}
