//
//  EditReminderView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 25/01/2023.
//

import SwiftUI

struct EditReminderView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var reminder: FetchedResults<Reminder>.Element
    
    @State private var title = ""
    @State private var summary = ""
    @State private var date = Date()
    @State private var shouldRepeat: Bool = false
    @State private var completed: Bool = false
    @State private var frequency: String = ""
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Title")
                            .labelModifier()
                        TextField("Title", text: $title)
                            .inputFieldModifier()
                    }
                    .sectionModifier()
                    .onAppear {
                        title = reminder.title!
                        summary = reminder.summary!
                        date = reminder.date!
                        shouldRepeat = reminder.shouldRepeat
                        completed = reminder.completed
                        frequency = reminder.frequency ?? "daily"
                    }
                    VStack(alignment: .leading) {
                        Text("Summary")
                            .labelModifier()
                        TextField("Summary", text: $summary)
                            .inputFieldModifier()
                    }
                    .sectionModifier()
                    VStack(alignment: .leading) {
                        DatePicker("Date", selection: $date, in: Date()...)
                    }
                    .padding()
                    
                    Toggle("Repeat", isOn: $shouldRepeat)
                        .background(.gray.opacity(0.3))
                    
                    if shouldRepeat {
                        Picker("Pick a frequency", selection: $frequency) {
                            Text("daily").tag("daily")
                            Text("weekly").tag("weekly")
                            Text("monthly").tag("monthly")
                            Text("yearly").tag("yearly")
                        }
                        .animation(.easeInOut, value: shouldRepeat)
                    }
                    HStack {
                        Spacer()
                        Button {
                            DataController().editReminder(reminder: reminder, title: title, summary: summary, date: date, shouldRepeat: shouldRepeat, frequency: frequency, completed: completed, context: managedObjectContext)
                            print(frequency)
                            dismiss()
                        } label: {
                            Text("Submit")
                                .submitButtonModifier()
                        }
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            
            Image(systemName: "goforward.plus")
                .resizable()
                .scaledToFit()
                .opacity(0.2)
                .position(x: UIScreen.main.bounds.width * 0.7,
                          y : UIScreen.main.bounds.height * 0.7)
        }
    }
}

//struct EditReminderView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditReminderView()
//    }
//}
