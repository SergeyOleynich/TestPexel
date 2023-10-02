//
//  TableViewCell.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 02.10.2023.
//

import Foundation

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
