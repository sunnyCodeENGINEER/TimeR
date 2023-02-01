//
//  BackgroundNightSkyOverlay.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 18/01/2023.
//

import SwiftUI

struct BackgroundNightSkyOverlay: View {
    @State private var timeString: Double = 0
    @State private var timeStringTest: Double = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var opacity1: CGFloat = 0
    @State private var opacity2: CGFloat = 0
    
    @State private var animateOpacity1: Bool = false
    @State private var animateOpacity2: Bool = false
    
    @State var try1 = ""
    @State var try2 = ""
    
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.black,
                                    .clear],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .opacity(opacity1)
                .animation(.linear, value: animateOpacity1)
            
            LinearGradient(colors: [.clear,
                                    .black],
                           startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
                .opacity(opacity2)
                .animation(.linear, value: animateOpacity2)
            
//            VStack {
//                Text(String(timeString))
//                Text(String(timeStringTest))
//                Text("\(opacity1)")
//                Text("\(opacity2)")
//            }
        }
        .onAppear {
            // new code goes here
            if timeString >= 22 && timeString < 24 {
                opacity2 = 1
            }
            if timeString >= 21 && timeString < 24 {
                opacity1 = 1
            }
            if timeString >= 0 && timeString < 2 {
                opacity2 = 0
            }
            if timeString >= 0 && timeString < 3 {
                opacity1 = 0
            }
            print("here")
            
        }
        .onReceive(self.timer) { value in
            timeString = Double(BackgroundGradient().date24HourFormatter(time: value.formatted(.dateTime.hour()))) ?? 0
            
            switch timeString {
            case 2..<4:
                withAnimation {
                    animateOpacity2 = true
                    let constant =  timeInSeconds("04:00:00")
                    let currentTime = timeInSeconds(value.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)).minute().second()))
                    let temp = String((Double(constant) ?? 1) - ((Double(currentTime) ?? 1)))
                    
                    opacity2 = 1 - opacityDifference(temp)
                }
//                break
            case 3..<6:
                withAnimation {
                    animateOpacity1 = true
                    let constant =  timeInSeconds("06:00:00")
                    let currentTime = timeInSeconds(value.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)).minute().second()))
                    let temp = String((Double(constant) ?? 1) - ((Double(currentTime) ?? 1)))
                    
                    opacity1 = 1 - opacityDifference(temp)
                }
                break
            case 19..<22:
                withAnimation {
                    animateOpacity2 = false
                    let constant =  timeInSeconds("10:00:00")
                    let currentTime = timeInSeconds(value.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)).minute().second()))
                    let temp = String((Double(constant) ?? 1) - ((Double(currentTime) ?? 1)))
                    
                    opacity2 = 0 + opacityDifference(temp)
                    
                    print("\nO2")
                    print(temp)
                }
//                break
            case 18..<21:
                withAnimation {
                    animateOpacity1 = false
                    let constant =  timeInSeconds("09:00:00")
                    let currentTime = timeInSeconds(value.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)).minute().second()))
                    let temp = String((Double(constant) ?? 1) - ((Double(currentTime) ?? 1)))
                    
                    opacity1 = 0 + opacityDifference(temp)
                    
                    print("\nO1")
                    print(temp)
                }
                break
            default:
//                if timeString >= 22 && timeString < 24 {
//                    opacity2 = 1
//                }
//                if timeString >= 21 && timeString < 24 {
//                    opacity1 = 1
//                }
//                if timeString >= 0 && timeString < 2 {
//                    opacity2 = 1
//                }
//                if timeString >= 0 && timeString < 3 {
//                    opacity1 = 1
//                }
//                print("here")
                break
            }
        }
    }
    private func opacityDifference(_ timeInSeconds: String) -> Double {
        let time = Double(timeInSeconds)
        let step: Double = 1 / (time ?? 1)
        
        return step
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
}

struct BackgroundNightSkyOverlay_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundNightSkyOverlay()
    }
}

extension Date {
    static func - (lhs: Date, rhs: Date) -> TimeInterval {
        return lhs.timeIntervalSinceReferenceDate - rhs.timeIntervalSinceReferenceDate
    }
}
