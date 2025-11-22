//
//  Task.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import Foundation

public extension Task where Success == Never, Failure == Never {
  static func sleep(seconds: Double) async {
    try? await Task.sleep(for: .seconds(seconds))
  }
}
