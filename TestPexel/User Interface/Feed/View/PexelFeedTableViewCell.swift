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
        
        title.text = "Test"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        title.text = nil
        icon.image = nil
        feedImage.image = nil
    }
    
    func setup(with item: PexelFeedDisplayItem) {
        title.text = item.title
    }
}
