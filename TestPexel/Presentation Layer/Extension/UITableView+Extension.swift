//
//  UITableView+Extension.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 04.10.2023.
//

import UIKit

extension UITableView {
    func dequeueAndConfigureReusableCell<T: UITableViewCell & CellSetupable>(
        for indexPath: IndexPath,
        with model: T.Model
    ) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            preconditionFailure("Could not dequeue cell with identifier: \(T.reuseIdentifier)")
        }
        
        cell.setup(with: model)
        return cell
    }
}

extension UITableView {
    func dequeueAndConfigureReusableCell(
        for indexPath: IndexPath,
        model: TableItem
    ) -> UITableViewCell & AnyTableViewCell {
        guard let cell = dequeueReusableCell(
            withIdentifier: String(describing: model.cellType),
            for: indexPath) as? (UITableViewCell & AnyTableViewCell) else {
            preconditionFailure("\(String(describing: model.cellType)) does not conform to AnyTableViewCell")
        }
        
        cell.setupAny(model: model)
        
        return cell
    }
}
