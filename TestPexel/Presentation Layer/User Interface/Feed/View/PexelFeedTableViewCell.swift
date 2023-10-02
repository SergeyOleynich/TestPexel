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
    
    override func awakeFromNib() {
        super.awakeFromNib()
                
        feedImageView.layer.shadowOffset = Constants.shadowOffset
        feedImageView.layer.shadowRadius = Constants.shadowRadius
        feedImageView.layer.shadowOpacity = Constants.shadowOpacity
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
            cornerRadii: CGSize(width: Constants.shadowRadius, height: Constants.shadowRadius))
        .cgPath
    }
}

// MARK: - TableViewCell

extension PexelFeedTableViewCell: TableViewCell {
    func setup(with model: PexelFeedDisplayPhotographerItem) {
        title.text = model.title
        
        model.imageUrl.flatMap {
            model.delegate?.loadImage(for: $0, in: self.feedImageView.bounds.size, radius: Constants.shadowRadius - 2) {[weak self] image, url in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if url == model.imageUrl {
                        UIView.transition(with: self.feedImageView, duration: 0.2, options: .transitionCrossDissolve) {
                            self.feedImageView.image = image
                        }
                    }
                    else {
                        self.feedImageView.image = nil
                    }
                }
            }
        }
    }
}

// MARK: - Computed Properties

extension PexelFeedTableViewCell {
    private var feedImageViewShadowColor: CGColor {
        switch traitCollection.userInterfaceStyle {
        case .dark: return UIColor.white.cgColor
        case .light: return UIColor.black.cgColor
        
        default: return UIColor.clear.cgColor
        }
    }
}

// MARK: - Constants

private extension PexelFeedTableViewCell {
    enum Constants {
        static let shadowRadius = 10.0
        static let shadowOpacity: Float = 0.9
        static let shadowOffset = CGSize(width: 0, height: 0)
    }
}
