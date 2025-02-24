//
//  CounterListViewModel.swift
//  counter-app
//
//  Created by Rodrigo Esquivel on 24-02-25.
//

import SwiftData
import SwiftUI

protocol CountersList: ObservableObject {
    @MainActor
    func fetchCounters(modelContext: ModelContext) async
}

final class CountersListViewModel: CountersList {
    
    // MARK: - Internal Properties

    @Published var counters = [CounterModel]()
    @Published var errorTitle = "Error"
    @Published var errorMessage = ""
    @Published var errorAlertIsVisible = false
    
    // MARK: - Internal Methods
    
    func fetchCounters(modelContext: ModelContext) async {
        do {
            counters = try modelContext.fetch(FetchDescriptor<CounterModel>())
            errorAlertIsVisible = false
        } catch {
            errorMessage = "An error occurred by fetching counters"
            errorAlertIsVisible = true
        }
    }
}
