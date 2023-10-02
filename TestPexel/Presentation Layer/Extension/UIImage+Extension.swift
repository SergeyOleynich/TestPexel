//
//  UIImage+Extension.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation
import UIKit.UIImage

extension UIImage {
    func crop(to croppedSize: CGSize) -> UIImage {
        var scale: CGFloat = croppedSize.width / size.width
        
        if size.height * scale < croppedSize.height {
            scale = croppedSize.height / size.height
        }
        
        let croppedImSize = CGSize(width: croppedSize.width/scale, height: croppedSize.height/scale)
        let croppedImRect = CGRect(
            origin: CGPoint(
                x: (size.width-croppedImSize.width)/2.0,
                y: (size.height-croppedImSize.height)/2.0),
            size: croppedImSize)
        
        let r = UIGraphicsImageRenderer(size: croppedImSize)
        
        return r.image { _ in
            draw(at: CGPoint(x: -croppedImRect.origin.x, y: -croppedImRect.origin.y))
        }
    }
    
    func round(_ radius: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let result = renderer.image { _ in
            let rounded = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            rounded.addClip()
            
            if let cgImage = self.cgImage {
                UIImage(
                    cgImage: cgImage,
                    scale: self.scale,
                    orientation: self.imageOrientation)
                .draw(in: rect)
            }
        }
        return result
    }
}
