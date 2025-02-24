//
//  counter_appApp.swift
//  counter-app
//
//  Created by Rodrigo Esquivel on 24-02-25.
//

import SwiftData
import SwiftUI

@main
struct MainApp: App {

    // MARK: - Model Container
    
    private var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            CounterModel.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    // MARK: - Scene
    
    var body: some Scene {
        WindowGroup {
            CountersListView()
                .environmentObject(CountersListViewModel())
        }
        .modelContainer(sharedModelContainer)
    }
}
