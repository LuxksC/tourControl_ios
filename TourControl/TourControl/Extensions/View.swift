//
//  View.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

@MainActor
extension View {
  func smoothAnimation<Value: Equatable>(value: Value) -> some View {
    animation(.smooth(duration: 0.3), value: value)
  }
  
  @ViewBuilder
  func onChangeAsync<Value: Equatable>(of value: Value, _ action: @escaping () async -> Void) -> some View {
    if #available(iOS 17.0, *) {
      onChange(of: value) {
        Task {
          await action()
        }
      }
    } else {
      onChange(of: value) { _ in
        Task {
          await action()
        }
      }
    }
  }
}
