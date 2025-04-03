//
//  MainScreen.swift
//  TestAppTwo
//
//  Created by Ваня Науменко on 3.04.25.
//
// MainScreen.swift
import SwiftUI

struct MainScreen: View {
    @EnvironmentObject var appState: AppState
    @State private var showDeleteAlert = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("Добро пожаловать!")
                .font(.title)
            
            if let email = appState.currentUserEmail {
                Text(email)
                    .font(.headline)
                    .padding(.top, 10)
            }
            
            Spacer()
            
            Button(action: { showDeleteAlert = true }) {
                Text("Удалить аккаунт")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .alert("Удаление аккаунта", isPresented: $showDeleteAlert) {
                Button("Удалить", role: .destructive) {
                    deleteAccount()
                }
                Button("Отмена", role: .cancel) {}
            } message: {
                Text("Вы уверены, что хотите удалить свой аккаунт? Это действие нельзя отменить.")
            }
        }
    }
    
    private func deleteAccount() {
        guard let email = appState.currentUserEmail,
              let user = CoreDataManager.shared.findUser(email: email) else {
            return
        }
        
        CoreDataManager.shared.deleteUser(user)
        appState.logout()
    }
}

extension View {
    func previewSetup() -> some View {
        self
            .environmentObject(AppState())
            .environment(\.managedObjectContext, CoreDataManager.shared.context)
    }
}

// Использование:
struct SomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        MainScreen()
            .previewSetup()
    }
}
//
//#Preview {
//    MainScreen()
//}
