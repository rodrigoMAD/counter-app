//
//  NewCounter.swift
//  counter-app
//
//  Created by Rodrigo Esquivel on 24-02-25.
//

import SwiftUI

struct NewCounterView: View {
    
    // MARK: - Private Properties
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss

    @EnvironmentObject private var viewModel: NewCounterViewModel

    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            content
                .navigationTitle("New Counter")
                .toolbar { saveToolbar }
                .alert($viewModel.errorTitle.wrappedValue,
                       isPresented: $viewModel.errorAlertIsVisible,
                       actions: {},
                       message: { errorMessage })
        }
    }
    
    // MARK: - Content
    
    @ViewBuilder
    private var content: some View {
        VStack(alignment: .leading) {
            Text("Create a new counter for the counter list.")
                .font(.footnote)
                .padding(.bottom, 2)

            Text("Name")
                .font(.headline)

            TextField(
                "Enter name",
                text: $viewModel.name
            )
            Spacer()
        }.padding(16)
    }
    
    // MARK: - Error Message
    
    private var errorMessage: some View {
        Text(viewModel.errorMessage)
    }
    
    // MARK: - Toolbar
    
    private var saveToolbar: some View {
        Button("Save", action: storeCounter)
            .padding(.top, -90.5)
    }
    
    // MARK: - Action
    
    private func storeCounter() {
        Task {
            await viewModel
                .store(
                    modelContext: modelContext,
                    handler: {
                        dismiss()
                    }
                )
            
        }
    }
}

#Preview {
    NewCounterView()
        .environmentObject(NewCounterViewModel())
}
