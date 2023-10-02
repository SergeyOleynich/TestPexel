//
//  PexelFeedTableViewCell.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 28.09.2023.
//

import UIKit

protocol TableItem { }

protocol AnyTableViewCell {
    func setupAny(model: TableItem)
}

protocol TableViewCell: AnyTableViewCell {
    associatedtype Model
    
    func setup(with model: Model)
}

extension TableViewCell {
    func setupAny(model: TableItem) {
        guard let model = model as? Model else { preconditionFailure() }
        
        setup(with: model)
    }
}

final class PexelFeedTableViewCell: UITableViewCell, TableViewCell {
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
    
    func setup(with model: PexelFeedDisplayPhotographerItem) {
        title.text = model.title
    }
}
