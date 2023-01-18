//
//  BackgroundView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundView: View {
    var body: some View {
        ZStack {
            BackgroundGradient()
            
            BackgroundGlobe()
        }
    }
}

struct BackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundView()
    }
}
