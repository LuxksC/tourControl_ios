//
//  Image.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

@MainActor
extension Image {
  // MARK: - Constructor
  
  init(data: Data) {
    self = .init(uiImage: UIImage(data: data) ?? UIImage())
  }
  
  // MARK: - Helpers
  
  func imageColor(_ color: Color) -> some View {
    resizable()
      .renderingMode(.template)
      .foregroundStyle(color)
  }
}
