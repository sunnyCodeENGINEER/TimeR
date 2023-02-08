//
//  MissedEventsView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 30/01/2023.
//

import SwiftUI

struct MissedEventsView: View {
    @State var tryArray: [String] = ["hello", "hi", "welcome", "akwaaba"]
    let dateFormatter = DateFormatter()
    @State var testString = ""
    
    var body: some View {
        VStack {
            HStack {
                Text("Number of missed events")
                Spacer()
                Text("\(tryArray.count)")
                    .font(.title2)
                    .foregroundColor(.red)
            }.padding()
            Text("\(Date().formatted(date: .omitted, time: .standard))")
            List {
                ForEach(0..<tryArray.count, id: \.self) { index in
                    Text("\(tryArray[index])")
                        .swipeActions {
                            Button {
                                tryArray.remove(at: index)
                            } label: {
                                Text("Remove")
                            }
                            .tint(.red)
                        }
                }
            }
        }
        .onAppear {
            dateFormatter.dateFormat = "HH:mm:ssa"
            testString = (dateFormatter.date(from: "12:00:00am")?.formatted(date: .omitted, time: .standard))!
            tryArray.reverse()
        }
    }
}

struct MissedEventsView_Previews: PreviewProvider {
    static var previews: some View {
        MissedEventsView()
    }
}
