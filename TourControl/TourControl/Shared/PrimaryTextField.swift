//
//  PrimaryTextField.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

enum FieldState {
  case empty
  case error
  case success
}

protocol Focusable: Hashable {}

public enum RegisterFocusedField: Focusable {
  case name
  case email
  case password
  case confirmEmail
  case birthDate
}

enum PlaceholderAnimation {
  case fade
  case position
}

struct PrimaryTextField<FocusedField: Focusable>: View {
  // MARK: - Variables
  private var target: FocusedField
  private var title: String?
  private var placeholder: String?
  private var errorMessage: String?
  private var successCondition = true
  private var isSecureField = false
  private var rightView: AnyView?
  private var placeholderAnimation: PlaceholderAnimation = .fade
  
  @Binding private var text: String
  @State private var state: FieldState = .empty
  @FocusState.Binding var focusedField: FocusedField?
  
  private var primaryColor: Color {
    return .redPrimary
  }
  
  private var primaryLightColor: Color {
    return .white
  }
  
  private var borderColor: Color {
    if focusedField == target {
      return state == .error ? .redPrimary : .white
    }
    
    if text.isEmpty {
      return .gray
    }
    
    return .gray
  }
  
  // MARK: - Constructor
  
  init(
    text: Binding<String>,
    target: FocusedField,
    focusedField: FocusState<FocusedField?>.Binding
  ) {
    self.target = target
    _text = text
    _focusedField = focusedField
  }
  
  // MARK: - Modifirers
  
  func setPlaceholder(_ placeholder: String) -> Self {
    var view = self
    view.placeholder = placeholder
    return view
  }
  
  func setTitle(_ title: String) -> Self {
    var view = self
    view.title = title
    return view
  }
  
  func setErrorMessage(_ errorMessage: String) -> Self {
    var view = self
    view.errorMessage = errorMessage
    return view
  }
  
  func setSuccessCondition(_ successCondition: Bool) -> Self {
    var view = self
    view.successCondition = successCondition
    return view
  }
  
  func setRightView(_ rightView: some View) -> Self {
    var view = self
    view.rightView = AnyView(rightView)
    return view
  }
  
  func setIsSecureField(_ isSecureField: Bool) -> Self {
    var view = self
    view.isSecureField = isSecureField
    return view
  }
  
  func setPlaceholderAnimation(_ placeholderAnimation: PlaceholderAnimation) -> Self {
    var view = self
    view.placeholderAnimation = placeholderAnimation
    return view
  }
  
  // MARK: - Helpers
  
  private func setupState() {
    if text.isEmpty {
      return setState(.empty)
    }
    
    if successCondition {
      return setState(.success)
    }
    
    setState(.error)
  }
  
  private func setState(_ newState: FieldState) {
    withAnimation {
      state = newState
    }
  }
  
  // MARK: - Views
  
  @ViewBuilder private var titleView: some View {
    if let title {
      Text(title)
        .font(CustomFont.heading2.font)
        .foregroundColor(.white)
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder private var placeholderView: some View {
    if let placeholder {
      switch placeholderAnimation {
        case .fade:
          Text(placeholder)
            .foregroundColor(.gray)
            .opacity(text.isEmpty ? 1 : 0)
            .font(CustomFont.body2.font)
          
        case .position:
          Text(placeholder)
            .font(text.isEmpty ? CustomFont.body2.font : CustomFont.caption1.font)
            .foregroundColor(.gray)
            .offset(y: text.isEmpty ? 0 : -10)
      }
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder private var textField: some View {
    if isSecureField {
      SecureField("", text: $text)
    } else {
      TextField("", text: $text)
    }
  }
  
  private var textFieldView: some View {
    Group {
      switch placeholderAnimation {
        case .fade:
          textField
          
        case .position:
          textField
            .offset(y: text.isEmpty ? 0 : 6)
      }
    }
    .focused($focusedField, equals: target)
    .foregroundStyle(.white)
    .tint(.white)
    .font(CustomFont.body1.font)
    .textInputAutocapitalization(.never)
  }
  
  private var borderView: some View {
    RoundedRectangle(cornerRadius: 16)
      .fill(Color.redTerciary)
      .stroke(borderColor, lineWidth: 2)
  }
  
  private var horizontalView: some View {
    HStack(spacing: 8) {
      ZStack(alignment: .leading) {
        placeholderView
        textFieldView
      }
      
      if let rightView {
        rightView
      }
    }
  }
  
  @ViewBuilder private var errorView: some View {
    if let errorMessage {
      HStack(alignment: .top, spacing: 4) {
        Text(errorMessage)
          .foregroundStyle(.red)
          .font(CustomFont.body2.font)
          .lineLimit(2)
          .fixedSize(horizontal: false, vertical: true)
      }
      .transition(.move(edge: .top).combined(with: .opacity))
    } else {
      EmptyView()
    }
  }
  
  @ViewBuilder private var messageView: some View {
    if state == .error {
      errorView
    } else {
      EmptyView()
    }
  }
  
  private var contentView: some View {
    Group {
      horizontalView
        .padding(.vertical, 8)
    }
    .padding(.horizontal, 16)
  }
  
  // MARK: - Body
  
    var body: some View {
      VStack(alignment: .leading, spacing: 8) {
        titleView
        
        ZStack {
          borderView
          contentView
        }
        .frame(minHeight: 56)
        
        messageView
      }
      .smoothAnimation(value: focusedField == target)
      .smoothAnimation(value: text.isEmpty)
      .smoothAnimation(value: state)
      .fixedSize(horizontal: false, vertical: true)
      .onChangeAsync(of: text) {
        text = String(text)
        setupState()
      }
      .onChangeAsync(of: successCondition) {
        text = String(text)
        setupState()
      }
    }
}

// MARK: - Preview

#Preview {
  @Previewable @State var text = ""
  @Previewable @FocusState var focusedField: RegisterFocusedField?
  
  ZStack {
    Color.darkBluePrimary.ignoresSafeArea(.all)
    PrimaryTextField(
      text: $text,
      target: .email,
      focusedField: $focusedField
    )
    .setTitle("Email")
    .padding(.horizontal, 16)
  }
}
