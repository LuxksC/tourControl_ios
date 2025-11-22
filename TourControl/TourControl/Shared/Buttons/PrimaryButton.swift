//
//  PrimaryButton.swift
//  TourControl
//
//  Created by Lucas Souza on 22/11/25.
//

import SwiftUI

struct PrimaryButton: View {
  // MARK: - Variables
  
  private let title: String
  private let height: CGFloat
  private let isEnabled: Bool
  private let imageResource: ImageResource?
  private let action: () async -> Void
  
  @State private var isRunning = false
  @EnvironmentObject private var appContext: AppContext
  
  private var color: Color {
    return .redPrimary
  }
  
  private var disabledColor: Color {
    return .redSecondary
  }
  
  // MARK: - Constructor
  
  init(
    title: String,
    height: CGFloat = 48,
    isEnabled: Bool = true,
    imageResource: ImageResource? = nil,
    action: @escaping () async -> Void
  ) {
    self.title = title
    self.height = height
    self.action = action
    self.isEnabled = isEnabled
    self.imageResource = imageResource
  }
  
  // MARK: - Views
  
  private var contentView: some View {
    ZStack {
      Capsule()
        .foregroundStyle(isEnabled ? color : disabledColor)
        .smoothAnimation(value: isEnabled)
      
      HStack(spacing: 4) {
        if let imageResource {
          Image(imageResource)
            .imageColor(.white)
            .opacity(isRunning ? 0 : 1)
            .frame(height: height / 2)
        }
        
        ZStack {
          Text(title)
            .foregroundStyle(Color.white)
            .font(height == 32 ? CustomFont.heading3.font : CustomFont.heading2.font)
            .opacity(isRunning ? 0 : 1)
            .lineLimit(1)
          
          ProgressView()
            .opacity(isRunning ? 1 : 0)
            .tint(.white)
        }
        .smoothAnimation(value: isRunning)
      }
      .padding(.horizontal, 16)
    }
    .frame(height: height)
  }
  
  // MARK: - Body
  
  var body: some View {
    AsyncButton {
      isRunning = true
      await action()
      isRunning = false
    } label: {
      contentView
    }
    .disabled(isRunning || !isEnabled)
    .buttonStyle(SmoothPressedStyle())
  }
}

#Preview {
  ZStack {
    Color.darkBluePrimary.edgesIgnoringSafeArea(.all)
    
    VStack(spacing: 16) {
      PrimaryButton(title: "Continue") {
        await Task.sleep(seconds: 2)
      }
      
      PrimaryButton(
        title: "Continue",
        isEnabled: false
      ) {
        await Task.sleep(seconds: 2)
      }
    }
    .padding(24)
  }
}
