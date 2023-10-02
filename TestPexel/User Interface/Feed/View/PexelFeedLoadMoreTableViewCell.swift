//
//  PexelFeedLoadMoreTableViewCell.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 01.10.2023.
//

import UIKit

final class PexelFeedLoadMoreTableViewCell: UITableViewCell {
    @IBOutlet private weak var activityIndicatorView: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        activityIndicatorView.startAnimating()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicatorView.startAnimating()
    }
}

extension PexelFeedLoadMoreTableViewCell: TableViewCell {
    func setup(with model: PexelFeedDisplayLoadMoreItem) {
        model.onNextLoad()
    }
}
