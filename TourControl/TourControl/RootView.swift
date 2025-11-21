//
//  ContentView.swift
//  TourControl
//
//  Created by Lucas de Castro Souza on 16/11/25.
//

import SwiftUI

struct RootView: View {
    var body: some View {
        ZStack {
            Color.black
            
            VStack {
                Image("logo")
                    .imageScale(.large)
                
                Text("Tour Control")
                    .tint(.white)
            }
            .padding()
        }
    }
}

#Preview {
    RootView()
}
