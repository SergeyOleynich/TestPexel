//
//  PexelFeedTableViewCell.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

final class PexelFeedTableViewCell: UITableViewCell {
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var feedImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        icon.image = nil
        feedImage.image = nil
    }
}

// MARK: - TableViewCell

extension PexelFeedTableViewCell: TableViewCell {
    func setup(with model: PexelFeedDisplayPhotographerItem) {
        title.text = model.title
        
        model.imageUrl.flatMap {
            model.delegate?.loadImage(for: $0) {[weak self] image, url in
                if url == model.imageUrl {
                    self?.feedImage.image = image
                }
                else {
                    self?.feedImage.image = nil
                }
            }
        }
    }
}
