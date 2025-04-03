//
//  ModelForNavigation.swift
//  TestAppTwo
//
//  Created by Ваня Науменко on 3.04.25.
//

// AppState.swift
import SwiftUI

class AppState: ObservableObject {
    @Published var isLoggedIn: Bool = false
    @Published var currentUserEmail: String?
    
    func logout() {
        isLoggedIn = false
        currentUserEmail = nil
    }
}
