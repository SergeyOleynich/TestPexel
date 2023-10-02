//
//  PexelFeedTableViewCell.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

final class PexelFeedTableViewCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var feedImageView: UIImageView!
    
    private var feedImageViewShadowColor: CGColor {
        switch traitCollection.userInterfaceStyle {
        case .dark: return UIColor.white.cgColor
        case .light: return UIColor.black.cgColor
        
        default: return UIColor.clear.cgColor
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        feedImageView.layer.shadowOffset = CGSize(width: 0, height: 0)
        feedImageView.layer.shadowRadius = 10
        feedImageView.layer.shadowOpacity = 0.9
        feedImageView.layer.shadowColor = feedImageViewShadowColor
        
        feedImageView.clipsToBounds = false
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        super.traitCollectionDidChange(previousTraitCollection)
        
        feedImageView.layer.shadowColor = feedImageViewShadowColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        feedImageView.image = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
                
        feedImageView.layer.shadowPath = UIBezierPath(
            roundedRect: CGRect(origin: .init(x: 0, y: 0), size: feedImageView.bounds.size),
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: 10, height: 10)).cgPath
    }
}

// MARK: - TableViewCell

extension PexelFeedTableViewCell: TableViewCell {
    func setup(with model: PexelFeedDisplayPhotographerItem) {
        title.text = model.title
        
        model.imageUrl.flatMap {
            model.delegate?.loadImage(for: $0) {[weak self] image, url in
                guard let self = self else { return }
                
                if url == model.imageUrl {
                    self.feedImageView.image = image?
                        .resized(to: self.feedImageView.bounds.size)
                        .round(10)
                }
                else {
                    self.feedImageView.image = nil
                }
            }
        }
    }
}

extension UIImage {
    public func resized(to target: CGSize) -> UIImage {
        let imsize = size
        let ivsize = target

        var scale: CGFloat = ivsize.width / imsize.width
        if imsize.height * scale < ivsize.height {
            scale = ivsize.height / imsize.height
        }
        
        let croppedImsize = CGSize(width:ivsize.width/scale, height:ivsize.height/scale)
        let croppedImrect =
            CGRect(origin: CGPoint(x: (imsize.width-croppedImsize.width)/2.0,
                                   y: (imsize.height-croppedImsize.height)/2.0),
                   size: croppedImsize)
        let r = UIGraphicsImageRenderer(size:croppedImsize)
        let croppedIm = r.image { _ in
            draw(at: CGPoint(x:-croppedImrect.origin.x, y:-croppedImrect.origin.y))
        }
        
        return croppedIm
    }
    
    func round(_ radius: CGFloat) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
        let renderer = UIGraphicsImageRenderer(size: rect.size)
        let result = renderer.image { c in
            let rounded = UIBezierPath(roundedRect: rect, cornerRadius: radius)
            rounded.addClip()
            if let cgImage = self.cgImage {
                UIImage(cgImage: cgImage, scale: self.scale, orientation: self.imageOrientation).draw(in: rect)
            }
        }
        return result
    }
}
