//
//  TestAppTwoApp.swift
//  TestAppTwo
//
//  Created by Ваня Науменко on 3.04.25.
//

import SwiftUI

@main
struct TestAppTwoApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
