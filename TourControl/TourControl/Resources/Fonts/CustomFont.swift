//
//  CustomFont.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

@MainActor
struct CustomFont: Hashable {
  // MARK: - Variables
  
  let name: String
  let size: CGFloat
  
  // MARK: - Fonts
  
  static var superTitle: CustomFont { CustomFont(name: "BrunoAceSC-Regular", size: 32) }
  
  static var heading1: CustomFont { CustomFont(name: "BrunoAceSC-Regular", size: 24) }
  static var heading2: CustomFont { CustomFont(name: "BrunoAceSC-Regular", size: 20) }
  static var heading3: CustomFont { CustomFont(name: "BrunoAceSC-Regular", size: 18) }
  static var heading4: CustomFont { CustomFont(name: "BrunoAceSC-Regular", size: 16) }
  static var heading5: CustomFont { CustomFont(name: "BrunoAceSC-Regular", size: 14) }
  static var heading6: CustomFont { CustomFont(name: "BrunoAceSC-Regular", size: 12) }
  
  static var body1: CustomFont { CustomFont(name: "Lato-Regular", size: 16) }
  static var body2: CustomFont { CustomFont(name: "Lato-Regular", size: 14) }
  
  static var caption1: CustomFont { CustomFont(name: "Lato-Regular", size: 12) }
  static var caption2: CustomFont { CustomFont(name: "Lato-Regular", size: 10) }
  
  // MARK: - Properties
  
  var uiFont: UIFont {
    UIFont(name: name, size: size) ?? .systemFont(ofSize: size)
  }
  
  var font: Font {
    .custom(name, size: size)
  }
}
