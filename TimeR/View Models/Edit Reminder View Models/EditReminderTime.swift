//
//  EditReminderTime.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 25/01/2023.
//

import SwiftUI

struct EditReminderTime: View {
    var reminder: FetchedResults<Reminder>.Element
    
    @Binding var date: Date
    @Binding var hours: Double
    @Binding var minutes: Double
    
    @State private var setHours: Bool = true
    @State private var frameSize: Double = 0
    
    var body: some View {
        VStack {
            CircularSliderViewOverlay(setHours: $setHours, hours: $hours, minutes: $minutes)
                .onAppear {
                    hours = Double(date24HourFormatter(time: reminder.date!.formatted(.dateTime.hour()))) ?? 0
                    minutes = Double(date24HourFormatter(time: reminder.date!.formatted(.dateTime.minute()))) ?? 0
                }
            
            HStack {
                CircularSliderView(value: $hours, unit: "hrs", in: 0...24)
                    .frame(width: 200)
                CircularSliderView(value: $minutes, unit: "mins", in: 0...59)
                    .frame(width: 200)
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

//struct EditReminderTime_Previews: PreviewProvider {
//    static var previews: some View {
//        EditReminderTime()
//    }
//}

struct CircularSliderViewOverlay: View {
    let myBlack: Color = Color("myBlack")
    @Binding var setHours: Bool
    @Binding var hours: Double
    @Binding var minutes: Double
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 2) {
            Button {
                withAnimation {
                    setHours = true
                }
            } label: {
                HStack(spacing: 0) {
                    if hours < 9.5 {
                        Text("0")
//                            .font(setHours ? .largeTitle : .title2)
//                            .fontWeight(setHours ? .bold : .regular)
                    }
                    Text("\(hours, specifier: "%.0f")")
//                        .font(setHours ? .largeTitle : .title2)
//                        .fontWeight(setHours ? .bold : .regular)
                    }
                .font(.system(size: setHours ? 60 : 40, weight: setHours ? .bold : .regular, design:.rounded))
            }
            Text(":")
                .fontWeight(.bold)
            Button {
                withAnimation {
                    setHours = false
                }
            } label: {
                HStack(spacing: 0) {
                    if minutes < 9.5 {
                        Text("0")
//                            .font(setHours ? .title2 : .largeTitle)
//                            .fontWeight(setHours ? .regular : .bold)
                    }
                    Text("\(minutes, specifier: "%.0f")")
//                        .font(setHours ? .title2 : .largeTitle)
//                        .fontWeight(setHours ? .regular : .bold)
                }
                .font(.system(size: !setHours ? 60 : 30, weight: !setHours ? .bold : .regular, design:.rounded))
            }
        }
        .tint(myBlack)
    }
}
