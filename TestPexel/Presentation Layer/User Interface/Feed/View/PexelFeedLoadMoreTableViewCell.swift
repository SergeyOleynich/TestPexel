//
//  PexelFeedLoadMoreTableViewCell.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 01.10.2023.
//

import UIKit

final class PexelFeedLoadMoreTableViewCell: UITableViewCell {
    private let activityIndicatorView: UIActivityIndicatorView = {
        let activityIndicatorView = UIActivityIndicatorView(style: .large)
        activityIndicatorView.translatesAutoresizingMaskIntoConstraints = false
        activityIndicatorView.startAnimating()
        
        return activityIndicatorView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        addSubview(activityIndicatorView)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        preconditionFailure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        activityIndicatorView.startAnimating()
    }
}

// MARK: - TableViewCell

extension PexelFeedLoadMoreTableViewCell: TableViewCell {
    func setup(with model: PexelFeedDisplayLoadMoreItem) {
        model.onNextLoad()
    }
}

// MARK: - Private

private extension PexelFeedLoadMoreTableViewCell {
    func setupConstraints() {
        NSLayoutConstraint.activate([
            activityIndicatorView.centerXAnchor.constraint(equalTo: centerXAnchor),
            activityIndicatorView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor),
            activityIndicatorView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor)
        ])
    }
}
