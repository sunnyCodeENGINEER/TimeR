//
//  BackgroundGradient.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundGradient: View {
    @State var color1 = Color(0xFBC540)
    @State var color2 = Color(0xAD3304)
    @State var color3 = Color(0xFBA52B)
    @State var color4 = Color(0xEC5C04)
    @State var color5 = Color(0xD49C0C)
    var body: some View {
        ZStack {
            LinearGradient(colors: [color1, color2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
        }
    }
}

struct BackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradient()
    }
}

extension Color {
    init(_ hex: UInt, alpha: Double = 1) {
        self.init(.sRGB,
        red: Double((hex >> 16) & 0xFF) / 255,
                  green: Double((hex >> 8) & 0xFF) / 255,
                  blue: Double(hex & 0xFF) / 255,
                  opacity: alpha
        )
        
    }
}
