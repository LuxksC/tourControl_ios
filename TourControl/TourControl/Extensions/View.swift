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
}
