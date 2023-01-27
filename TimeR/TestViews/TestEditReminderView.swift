//
//  TestEditReminderView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import SwiftUI

struct TestEditReminderView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var reminder: FetchedResults<Reminder>.Element
    
    @State private var title = ""
    @State private var summary = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            Section {
                TextField("\(reminder.title!)", text: $title)
                    .onAppear {
                        title = reminder.title!
                        summary = reminder.summary!
                        date = reminder.date!
                    }
                VStack {
                    Text("Title")
                    TextField("Title", text: $title)
                }
                .padding()
                VStack {
                    Text("Summary")
                    TextField("Summary", text: $summary)
                }
                .padding()
                VStack {
                    DatePicker("Date", selection: $date, in: Date()...)
                }
                .padding()
                
                HStack {
                    Spacer()
                    Button {
                        DataController().editReminder(reminder: reminder, title: title, summary: summary, date: date, shouldRepeat: false, context: managedObjectContext)
                        dismiss()
                    } label: {
                        Text("Submit")
                            .font(.title)
                    }
                    Spacer()
                }
            }
        }
    }
}


