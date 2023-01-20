//
//  BackgroundSun.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundSun: View {
    @State private var timeString: Double = 0
    @State var xAxis: CGFloat = -50
    @State var yAxis: CGFloat = 300
    @State var xStep: CGFloat = 1
    @State var yStep: CGFloat = 1
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    @State var holder1 = ""
    @State var holder2 = ""
    @State var holder3 = ""
    @State var holder4 = ""
    
    var body: some View {
        ZStack {
            VStack {
                Text("\(xAxis)")
                Text("\(timeString)")
                Text("\(UIScreen.main.bounds.width * 1.3)")
                Text(holder1)
            }

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
//                xAxis += xStep
//                yAxis -= yStep
                
                timeString = Double(BackgroundGradient().date24HourFormatter(time: Date.now.formatted(.dateTime.hour())))!
                
                switch timeString {
                case 5..<12:
                    let constant =  timeInSeconds("04:59:59")
                    let currentTime = timeInSeconds(value.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)).minute().second()))
                    let temp = String((Double(currentTime) ?? 1) - ((Double(constant) ?? 1)))
                    holder1 = String(temp)
                    holder2 = String(currentTime)
                    
                    
                    xAxis = ((UIScreen.main.bounds.width * 1.3) / 43200) * Double(temp)! - 50
                    break
                case 12:
                    let constant =  timeInSeconds("04:59:59")
                    let currentTime = timeInSeconds(value.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)).minute().second()))
                    let temp = String((Double(currentTime) ?? 1) - ((Double(constant) ?? 1)))
                    holder1 = String(temp)
                    holder2 = String(currentTime)
                    
                    
                    xAxis = ((UIScreen.main.bounds.width * 1.3) / 43200) * Double(temp)! - 50
                case 13..<17:
                    let constant =  timeInSeconds("07:00:00")
                    let currentTime = timeInSeconds(value.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)).minute().second()))
                    let temp = String((Double(currentTime) ?? 1) + ((Double(constant) ?? 1)))
                    holder1 = String(temp)
                    holder2 = String(currentTime)
                    
                    
                    xAxis = ((UIScreen.main.bounds.width * 1.3) / 43200) * Double(temp)! - 50
                    break
                
                default:
                    break
                }
        }
        }
    }
    
    private func timeInSeconds(_ timeInHours: String = "03:00:00") -> String {
        var time = timeInHours
        
        let seconds = addElement()
        let minutes = addElement()
        let hours = addElement()
        
        let result = seconds + (minutes * 60) + (hours * 3600)
        
        func addElement() -> Int {
            var temp: String = String(time.removeLast())
            temp = String(time.removeLast()) + temp
            if !time.isEmpty {
                time.removeLast()
            }
            
            return Int(temp) ?? 0
        }
        
        return String(result)
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
