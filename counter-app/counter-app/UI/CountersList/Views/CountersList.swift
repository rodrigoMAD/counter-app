//
//  CountersList.swift
//  counter-app
//
//  Created by Rodrigo Esquivel on 24-02-25.
//

import SwiftUI

struct CountersListView: View {
    
    // MARK: - Private Properties
    
    @Environment(\.modelContext) var modelContext
    
    @EnvironmentObject private var viewModel: CountersListViewModel
    
    @State private var errorAlert = false

    // MARK: - Body
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("Counters List")
                .toolbar { counterListToolbar }
                .onAppear { loadCounters() }
                .alert($viewModel.errorTitle.wrappedValue,
                       isPresented: $viewModel.errorAlertIsVisible,
                       actions: {},
                       message: { errorMessage })
        }
    }
    
    // MARK: - Content
    
    @ViewBuilder
    private var content: some View {
        List {
            ForEach(viewModel.counters) { counter in
                HStack {
                    Text(counter.name)
                    Spacer()
                    Text("\(counter.count)")
                    Stepper { }
                    onIncrement: { incrementStep(id: counter.id) }
                    onDecrement: { decrementStep(id: counter.id) }
                        .padding(.leading, 16)
                }
            }
        }.overlay {
            if viewModel.counters.isEmpty {
                Text("No counters to show")
            }
        }
    }
    
    // MARK: - Toolbar
    
    private var counterListToolbar: some View {
        NavigationLink(
            destination: NewCounterView()
                .environmentObject(NewCounterViewModel())
            
        ) {
            Image(systemName: "plus")
        }
    }
    
    // MARK: - Error Message
    
    private var errorMessage: some View {
        Text(viewModel.errorMessage)
    }
    
    // MARK: - Private Methods
    
    private func loadCounters() {
        Task {
            await viewModel.fetchCounters(modelContext: modelContext)
        }
    }
    
    private func incrementStep(id: UUID) {
        let counter = viewModel.counters.first { $0.id == id }
        counter?.count += 1
    }
    
    private func decrementStep(id: UUID) {
        let counter = viewModel.counters.first { $0.id == id }
        counter?.count -= 1
    }
}

#Preview {
    CountersListView()
        .environmentObject(CountersListViewModel())
    
}
