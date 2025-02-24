//
//  CounterModel.swift
//  counter-app
//
//  Created by Rodrigo Esquivel on 24-02-25.
//

import Foundation
import SwiftData

@Model
final class CounterModel {

    // MARK: - Internal Properties
    
    var id: UUID
    var name: String
    var count: Int
    
    // MARK: - Initializer
    
    init(id: UUID, name: String, count: Int) {
        self.id = id
        self.name = name
        self.count = count
    }
}
