//
//  BackgroundGlobe.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundGlobe: View {
    @EnvironmentObject var colorScheme: TimeColorScheme
    
    @State var color: Color = .green
    var body: some View {
        Image(systemName: "globe.europe.africa.fill")
            .resizable()
            .frame(width: UIScreen.main.bounds.width * 1.5, height: UIScreen.main.bounds.width * 1.5)
            .scaledToFit()
            .position(x: UIScreen.main.bounds.width * 0.7, y: UIScreen.main.bounds.height * 0.8)
            .foregroundColor(colorScheme.color3)
    }
}

struct BackgroundGlobe_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGlobe()
    }
}
