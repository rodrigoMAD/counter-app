//
//  NewCounterViewModel.swift
//  counter-app
//
//  Created by Rodrigo Esquivel on 24-02-25.
//

import SwiftData
import SwiftUI

// MARK: - Interface

protocol NewCounter: ObservableObject {
    @MainActor
    func store(modelContext: ModelContext, handler: @escaping () -> Void) async
}

// MARK: Implementation

final class NewCounterViewModel: NewCounter {
    
    // MARK: - Internal Properties
    
    @Published var name = ""
    @Published var count = 0
    @Published var errorTitle = "Error"
    @Published var errorMessage = "An error occurred by storing a counter"
    @Published var errorAlertIsVisible = false
    
    // MARK: - Internal Methods
    
    func store(modelContext: ModelContext, handler: @escaping () -> Void) async {
        do {
            try modelContext.transaction {
                let counter = CounterModel(id: UUID(), name: name, count: count)
                modelContext.insert(counter)
                errorAlertIsVisible = false
                handler()
            }
        } catch {
            errorAlertIsVisible = true
        }
    }
}
