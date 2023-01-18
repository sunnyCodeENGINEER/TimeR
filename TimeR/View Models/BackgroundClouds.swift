//
//  BackgroundClouds.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundClouds: View {
    @State private var xAxis: CGFloat = 0
    @State private var yAxis: CGFloat = 400
    @State private var xSize: CGFloat = 0
    @State private var ySize: CGFloat = 0
    
    var body: some View {
        ZStack {
            Cloud(imageName: "Clouds2", xAxis: 0, yAxis: 500, xSize: 300, ySize: 200, animationDuration: 600, scaleFactor: 1.3)
            Cloud(imageName: "Clouds1", xAxis: 200, yAxis: 50, xSize: 150, ySize: 100, animationDuration: 60, scaleFactor: 0.8)
            Cloud(imageName: "Clouds2", xAxis: 300, yAxis: 800, xSize: 400, ySize: 300, animationDuration: 10800, scaleFactor: 1.3)
            Cloud(imageName: "Clouds2", xAxis: 400, yAxis: 350, xSize: 600, ySize: 400, animationDuration: 600, scaleFactor: 1.3)
                .opacity(0.3)
            Cloud(imageName: "Clouds1", xAxis: 0, yAxis: 400, xSize: 600, ySize: 400, animationDuration: 21600, scaleFactor: 1.3)
        }
    }
}

struct BackgroundClouds_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundClouds()
    }
}

struct Cloud: View {
    let imageName: String
    let xAxis: CGFloat
    let yAxis: CGFloat
    let xSize: CGFloat
    let ySize: CGFloat
    let animationDuration: CGFloat
    let scaleFactor: Double
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State private var animate = false
    
    var body: some View {
        VStack {
            Image(imageName)
                .resizable()
                .frame(width: xSize, height: ySize)
                .scaledToFit()
                .position(x: animate ? UIScreen.main.bounds.width * scaleFactor : xAxis, y: yAxis)
                .animation(.linear(duration: animationDuration).repeatForever(), value: animate)
        }
        .background(.black.opacity(0.5))
        .onAppear {
            withAnimation {
                animate = true
            }
        }
    }
    
    private func cloudAnimationStepper() -> CGFloat {
        let xStep = (UIScreen.main.bounds.width * 1.3) / 20
        
        return xStep
    }
}

