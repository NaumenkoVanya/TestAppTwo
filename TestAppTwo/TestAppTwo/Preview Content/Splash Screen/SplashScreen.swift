//
//  SplashScreen.swift
//  TestAppTwo
//
//  Created by Ваня Науменко on 3.04.25.
//

import SwiftUI

struct SplashScreen: View {
    var body: some View {
        ZStack {
            Image("splash_background")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            
            ProgressView()
                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                .scaleEffect(2)
        }
    }
}

#Preview {
    SplashScreen()
}
