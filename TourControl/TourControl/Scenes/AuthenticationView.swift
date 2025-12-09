//
//  AuthenticationView.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

enum AuthType {
  case login
  case signup
}

enum GenderType {
  case male
  case female
}

struct AuthenticationView: View {
  // MARK: - Variables
  @State private var authType: AuthType = .signup
  @State private var email: String = ""
  @State private var password: String = ""
  @State private var gender: GenderType = .male
  @State private var birthDate: String = ""
  @State private var name: String = ""
  @FocusState var focusedField: RegisterFocusedField?
  
  // MARK: - Constructor
  init(
    type: AuthType
  ) {
    self.authType = type
  }
  
  // MARK: - Helpers
  
  private func continuePressed() {
    print("Continue Pressed")
  }
  
  private func sendAuthRequest() {
    print("Auth Request")
  }
  
  // MARK: - Views
  
  private var titleView: some View {
    Text("Title View")
  }
  
  private var genderSelectorView: some View {
    Text("Genders Textfield")
  }
  
  private var nameTextFieldView: some View {
    PrimaryTextField(text: $name, target: .name, focusedField: $focusedField)
      .setTitle("Name")
  }
  
  private var birthDateTextFieldView: some View {
    PrimaryTextField(text: $birthDate, target: .birthDate, focusedField: $focusedField)
      .setTitle("Birth Date")
  }
  
  private var emailTextFieldView: some View {
    PrimaryTextField(text: $email, target: .email, focusedField: $focusedField)
      .setTitle("Email")
  }
  
  private var passwordTextFieldView: some View {
    PrimaryTextField(text: $password, target: .password, focusedField: $focusedField)
      .setTitle("Password")
  }
  
  @ViewBuilder private var contentView: some View {
    VStack {
      titleView
      
      if authType == .signup {
        genderSelectorView
        
        HStack {
          nameTextFieldView
          
          birthDateTextFieldView
        }
      }
      
      emailTextFieldView
      
      passwordTextFieldView
      
      Spacer()
      
      PrimaryButton(title: "Continue") {
        continuePressed()
      }
    }
    .padding()
  }
  
  // MARK: - Body
  
  var body: some View {
    ZStack {
      Color.darkBluePrimary.ignoresSafeArea(.all)
      
      contentView
    }
  }
}

// MARK: - Preview

#Preview {
  AuthenticationView(type: .signup)
}
