//
//  SmoothPressedStyle.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

struct SmoothPressedStyle: ButtonStyle {
  // MARK: - Body
  
  func makeBody(configuration: Self.Configuration) -> some View {
    configuration
      .label
      .transition(.opacity)
      .opacity(configuration.isPressed ? 0.6 : 1)
      .scaleEffect(configuration.isPressed ? 0.98 : 1)
      .smoothAnimation(value: configuration.isPressed)
  }
}
