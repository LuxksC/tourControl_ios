//
//  WelcomeView.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

struct WelcomeView: View {
  
  // MARK: - Helpers
  
  private func loginPressed() {
    print("login pressed")
  }
  
  private func signupPressed() {
    print("signup pressed")
  }
  
  // MARK: - Views
  
  private var logo: some View {
    VStack {
      Image("logo")
        .aspectRatio(contentMode: .fit)
        .frame(width: 170)
      
      Text("Tournament\nControl")
        .font(CustomFont.superTitle.font)
        .foregroundStyle(.white)
        .multilineTextAlignment(.center)
    }
  }
  
  private var loginButton: some View {
    PrimaryButton(title: "Login") {
      loginPressed()
    }
  }
  
  private var signupButton: some View {
    SecondaryButton(title: "Criar conta") {
      signupPressed()
    }
  }
  
  // MARK: - Body
  
  var body: some View {
    ZStack {
      Color.darkBluePrimary.edgesIgnoringSafeArea(.all)
      
      VStack(spacing: 64) {
        logo
        
        VStack(spacing: 16) {
          loginButton
          signupButton
        }
      }
      .padding(.horizontal, 32)
    }
  }
}

// MARK: - Preview

#Preview {
    WelcomeView()
}
