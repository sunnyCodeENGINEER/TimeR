//
//  BackgroundSun.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundSun: View {
    @State var xAxis: CGFloat = 0
    @State var yAxis: CGFloat = 300
    @State var xStep: CGFloat = 1
    @State var yStep: CGFloat = 1
    @State private var timer = Timer.publish(every: 60, on: .main, in: .common).autoconnect()
    
    var body: some View {
        VStack {
            Image("SunIcon")
                .resizable()
                .frame(width: 200, height: 200)
                .rotationEffect(Angle(degrees: 30))
                .scaledToFit()
                .position(x: xAxis, y: yAxis)
        }
        .background(.black.opacity(0.5))
        .onAppear {
            xStep = sunAnimationStepper().0
            yStep = sunAnimationStepper().1
            
        }
        .onReceive(self.timer) { value in
            xAxis += xStep
            yAxis -= yStep
        }
    }
    
    private func sunAnimationStepper() -> (CGFloat, CGFloat) {
        let xStep = (UIScreen.main.bounds.width * 1.3) / 780
        let yStep: CGFloat = (250) / 780
        
        return (xStep, yStep)
    }
}

struct BackgroundSun_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundSun()
    }
}
