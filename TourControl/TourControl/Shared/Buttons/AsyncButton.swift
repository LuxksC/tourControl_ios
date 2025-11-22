//
//  AsyncButton.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

struct AsyncButton<Label: View>: View {
  // MARK: - Variables
  
  private let label: Label
  private let action: () async -> Void
  
  @State private var isRunning = false
  
  // MARK: - Constructor
  
  init(
    action: @escaping () async -> Void,
    @ViewBuilder label: () -> Label
  ) {
    self.action = action
    self.label = label()
  }
  
  // MARK: - Body
  
  var body: some View {
    Button {
      Task {
        isRunning = true
        await action()
        isRunning = false
      }
    } label: {
      label
    }
    .buttonStyle(SmoothPressedStyle())
    .disabled(isRunning)
  }
}

// MARK: - Previews

#Preview {
  AsyncButton {
    await Task.sleep(seconds: 10)
  } label: {
    Text("Button")
  }
}
