//
//  BackgroundGradient.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct BackgroundGradient: View {
    @EnvironmentObject var colorScheme: TimeColorScheme
    
    @State private var timeString: Double = 0
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    @State private var trial = ""
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [colorScheme.color1, colorScheme.color2], startPoint: .topLeading, endPoint: .bottomTrailing)
                .ignoresSafeArea()
            
            VStack {
                Text(String(timeString))
                
                Text(trial)
            }
        }
        .onReceive(self.timer) { value in
            let temp = date24HourFormatter(time: Date.now.formatted(.dateTime.hour()))
            
//            timeString = Double(Date.now.formatted(.dateTime.hour(.conversationalDefaultDigits(amPM: .omitted)))) ?? 0
            timeString = Double(temp) ?? 0
            
            switch timeString {
            case 1..<3:
                trial = "Success"
                // done
                colorScheme.color1 = Color(0x3D1C51)
                colorScheme.color2 = Color(0x8848B4)
                colorScheme.color3 = Color(0x7E397C)
                colorScheme.color4 = Color(0xD7798B)
                colorScheme.color5 = Color(0x9C91CD)
                break
            case 3..<5:
                // done
                colorScheme.color1 = Color(0x374F6D)
                colorScheme.color2 = Color(0xA4A484)
                colorScheme.color3 = Color(0x23233B)
                colorScheme.color4 = Color(0xDC443C)
                colorScheme.color5 = Color(0xDFBD80)
                break
            case 5..<7:
                // done
                colorScheme.color1 = Color(0xF3ECD0)
                colorScheme.color2 = Color(0xC0C9B8)
                colorScheme.color3 = Color(0x634C22)
                colorScheme.color4 = Color(0xE6B15D)
                colorScheme.color5 = Color(0xFEE197)
                break
            case 7..<10:
                // done
                colorScheme.color1 = Color(0x7EACC7)
                colorScheme.color2 = Color(0xD4D7CF)
                colorScheme.color3 = Color(0x57623E)
                colorScheme.color4 = Color(0x885B21)
                colorScheme.color5 = Color(0xAD5914)
                break
            case 10..<12:
                // done
                colorScheme.color1 = Color(0x22BED9)
                colorScheme.color2 = Color(0xDDDED1)
                colorScheme.color3 = Color(0x256940)
                colorScheme.color4 = Color(0x64B8B1)
                colorScheme.color5 = Color(0x738B13)
                break
            case 12..<15:
                // done
                colorScheme.color1 = Color(0x6C9A8B)
                colorScheme.color2 = Color(0xF1C993)
                colorScheme.color3 = Color(0x8C9833)
                colorScheme.color4 = Color(0x6E9D6C)
                colorScheme.color5 = Color(0xE1A052)
                break
            case 15..<17:
                
                colorScheme.color1 = Color(0xFBC540)
                colorScheme.color2 = Color(0xAD3304)
                colorScheme.color3 = Color(0xEC5C04)
                colorScheme.color4 = Color(0xFBA52B)
                colorScheme.color5 = Color(0xD49C0C)
                break
            case 17..<21:
                // done
                colorScheme.color1 = Color(0x351C4D)
                colorScheme.color2 = Color(0x765285)
                colorScheme.color3 = Color(0xFF7E5F)
                colorScheme.color4 = Color(0xFEB47B)
                colorScheme.color5 = Color(0xF5AB99)
                break
            case 21..<0:
                // done
                colorScheme.color1 = Color(0x0E0A14)
                colorScheme.color2 = Color(0x3D3772)
                colorScheme.color3 = Color(0xCE751D)
                colorScheme.color4 = Color(0x642F1F)
                colorScheme.color5 = Color(0x1D1D43)
                break
            default:
                break
            }
        }
    }
    
    func date24HourFormatter(time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hha"
        
        let date = dateFormatter.date(from: time)
        dateFormatter.dateFormat = "HH"
        
        let time24 = dateFormatter.string(from: date!)
        return time24
    }
}

struct BackgroundGradient_Previews: PreviewProvider {
    static var previews: some View {
        BackgroundGradient().environmentObject(TimeColorScheme())
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
