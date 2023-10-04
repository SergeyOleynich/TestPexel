//
//  CellSetupable.swift
//  TestPexel
//
//  Created by Serhii Oleinich on 04.10.2023.
//

import Foundation

protocol CellSetupable {
    associatedtype Model
    
    static var reuseIdentifier: String { get }
    
    func setup(with model: Model)
}
