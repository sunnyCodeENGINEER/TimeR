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
    @State var hours: Double = 0
    @State var minutes: Double = 0
    
    var body: some View {
        VStack {
            EditReminderTitleField(reminder: reminder, title: $title, summary: $summary)
            
            EditReminderTime(reminder: reminder, date: $date, hours: $hours, minutes: $minutes)
            
            DatePicker("Date", selection: $date, in: Date.now...)
            
            HStack {
                Spacer()
                Button {
//                    let day = date.formatted(.dateTime.day(.twoDigits))
//                    let month = date.formatted(.dateTime.month(.twoDigits))
//                    let year = date.formatted(.dateTime.year())
//                    
//                    let df = DateFormatter()
//                    df.dateFormat = "yyy-MM-dd'T'HH:mm:ss"
//                    
//                    let isoDate = "\(year)-\(month)-\(day)T\(hours):\(minutes):00"
//                    let reminderDate = df.date(from: isoDate)
                    
                    DataController().editReminder(reminder: reminder, title: title, summary: summary, date: date, context: managedObjectContext)
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

//struct EditReminderView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditReminderView()
//    }
//}
