//
//  BackgroundMoon.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundMoon: View {
    @State var xAxis: CGFloat = 0
    @State var yAxis: CGFloat = 200
    @State var xStep: CGFloat = 1
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image("MoonIcon")
                .resizable()
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: 30))
                .scaledToFit()
                .position(x: xAxis, y: yAxis)
        }
        .background(.black.opacity(0.5))
        .onAppear {
            xStep = moonAnimationStepper()
            
        }
        .onReceive(self.timer) { value in
            xAxis += xStep
        }
    }
    
    private func moonAnimationStepper() -> CGFloat {
        let xStep = (UIScreen.main.bounds.width * 1.3) / 420
        
        return xStep
    }
}

struct BackgroundMoon_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundMoon()
    }
}
