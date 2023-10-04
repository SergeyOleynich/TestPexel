//
//  PexelFeedTableViewCell.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

final class PexelFeedTableViewCell: UITableViewCell {
    private let title: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
        
        return label
    }()
    
    private let feedImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.layer.shadowOffset = Constants.shadowOffset
        imageView.layer.shadowRadius = Constants.shadowRadius
        imageView.layer.shadowOpacity = Constants.shadowOpacity
        
        imageView.clipsToBounds = false
        
        return imageView
    }()
    
    private let contentStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 8
        
        return stackView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup(view: contentView)
        setupConstraints()
        
        feedImageView.layer.shadowColor = feedImageViewShadowColor
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure()
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
}

// MARK: - TableViewCell

extension PexelFeedTableViewCell: TableViewCell {
    func setup(with model: PexelFeedDisplayPhotographerItem) {
        title.text = model.title
        feedImageView.layer.shadowColor = nil
        
        DispatchQueue.main.async {[weak self] in
            self?.updateFeedImageViewShadowPath()
            self?.asyncSetFeedImage(from: model)
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

// MARK: - Private

private extension PexelFeedTableViewCell {
    func setup(view: UIView) {
        contentStackView.addArrangedSubview(title)
        contentStackView.addArrangedSubview(feedImageView)
        
        view.addSubview(contentStackView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            contentStackView.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            contentStackView.bottomAnchor.constraint(equalTo: contentView.layoutMarginsGuide.bottomAnchor, constant: -8),
            contentStackView.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            contentStackView.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            
            feedImageView.heightAnchor.constraint(greaterThanOrEqualTo: feedImageView.widthAnchor, multiplier: 0.5)
        ])
    }
    
    func updateFeedImageViewShadowPath() {
        let shadowPath = UIBezierPath(
            roundedRect: CGRect(origin: .init(x: 0, y: 0), size: feedImageView.bounds.size),
            byRoundingCorners: .allCorners,
            cornerRadii: CGSize(width: Constants.shadowRadius, height: Constants.shadowRadius))
        .cgPath
        
        if feedImageView.layer.shadowPath != shadowPath {
            feedImageView.layer.shadowPath = shadowPath
        }
    }
    
    func asyncSetFeedImage(from model: PexelFeedDisplayPhotographerItem) {
        guard let imageUrl = model.imageUrl else {
            feedImageView.image = nil
            return
        }
        
        model.delegate?.loadImage(
            for: imageUrl,
            in: feedImageView.bounds.size,
            radius: Constants.shadowRadius - 2,
            completion: {[weak self] image, url in
                guard let self = self else { return }
                
                DispatchQueue.main.async {
                    if url == model.imageUrl {
                        UIView.transition(
                            with: self.feedImageView,
                            duration: UINavigationController.hideShowBarDuration,
                            options: .transitionCrossDissolve,
                            animations: {
                                if self.feedImageView.layer.shadowColor != self.feedImageViewShadowColor {
                                    self.feedImageView.layer.shadowColor = self.feedImageViewShadowColor
                                }
                                
                                self.feedImageView.image = image
                            }
                        )
                    }
                    else {
                        self.feedImageView.layer.shadowColor = nil
                        self.feedImageView.image = nil
                    }
                }
            }
        )
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
