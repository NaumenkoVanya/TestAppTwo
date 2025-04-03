//
//  RegistrationScreen.swift
//  TestAppTwo
//
//  Created by Ваня Науменко on 3.04.25.
//
// RegistrationScreen.swift
import SwiftUI

struct RegistrationScreen: View {
    @EnvironmentObject var appState: AppState
    @Environment(\.dismiss) var dismiss
    
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var emailError = ""
    @State private var passwordError = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Text("Регистрация")
                .font(.largeTitle)
                .padding(.bottom, 30)
            
            TextField("Email", text: $email)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .textContentType(.emailAddress)
            
            if !emailError.isEmpty {
                Text(emailError)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            SecureField("Пароль", text: $password)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.newPassword)
            
            SecureField("Подтвердите пароль", text: $confirmPassword)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .textContentType(.newPassword)
            
            if !passwordError.isEmpty {
                Text(passwordError)
                    .foregroundColor(.red)
                    .font(.caption)
            }
            
            Button(action: register) {
                Text("Зарегистрироваться")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 20)
            
            Spacer()
        }
        .padding()
        .navigationBarTitle("Регистрация", displayMode: .inline)
    }
    
    private func register() {
        emailError = ""
        passwordError = ""
        
        // Валидация email
        if !isValidEmail(email) {
            emailError = "Введите корректный email"
            return
        }
        
        // Валидация пароля
        if password.count < 8 {
            passwordError = "Пароль должен содержать не менее 8 символов"
            return
        }
        
        if password != confirmPassword {
            passwordError = "Пароли не совпадают"
            return
        }
        
        // Проверка на существующего пользователя
        if CoreDataManager.shared.findUser(email: email) != nil {
            emailError = "Пользователь с таким email уже существует"
            return
        }
        
        // Сохранение пользователя
        CoreDataManager.shared.createUser(email: email, password: password)
        
        // Авторизация и переход на главный экран
        appState.currentUserEmail = email
        appState.isLoggedIn = true
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

#Preview {
    RegistrationScreen()
}
