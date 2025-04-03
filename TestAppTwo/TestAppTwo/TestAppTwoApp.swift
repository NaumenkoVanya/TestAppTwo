//
//  TestAppTwoApp.swift
//  TestAppTwo
//
//  Created by Ваня Науменко on 3.04.25.
//

import SwiftUI

//@main
//struct TestAppTwoApp: App {
//
//    var body: some Scene {
//        WindowGroup {
//            ContentView()
//        }
//    }
//}

// UserAuthApp.swift
import SwiftUI

@main
struct TestAppTwoApp: App {
    @StateObject private var appState = AppState()
    @State private var showSplash = true
    
    var body: some Scene {
        WindowGroup {
            Group {
                if showSplash {
                    SplashScreen()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                                withAnimation {
                                    showSplash = false
                                }
                            }
                        }
                } else {
                    if appState.isLoggedIn {
                        MainScreen()
                            .environmentObject(appState)
                    } else {
                        UsersListScreen()
                            .environmentObject(appState)
                    }
                }
            }
        }
    }
}
