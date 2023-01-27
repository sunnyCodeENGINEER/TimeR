//
//  UpcomingEventsActionSheet.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 26/01/2023.
//

import SwiftUI

struct UpcomingEventsActionSheet: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var reminder: FetchedResults<Reminder>.Element
    
    @State private var title = ""
    @State private var summary = ""
    @State private var date = Date()
    @State private var shouldRepeat: Bool = false
    @State private var completed: Bool = false
    
    var body: some View {
        VStack {
            Button {
                reminder.completed = true
//                DataController().editReminder(reminder: reminder, title: title, summary: summary, date: date, shouldRepeat: shouldRepeat, completed: completed, context: managedObjectContext)
                DataController().save(context: managedObjectContext)
                dismiss()
            } label: {
                Text("Completed")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                        .stroke()
                        .background(.thickMaterial))
            }
            .onAppear {
                title = reminder.title!
                summary = reminder.summary!
                date = reminder.date!
                shouldRepeat = reminder.shouldRepeat
                completed = reminder.completed
            }
        }
    }
}
//
//struct UpcomingEventsActionSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingEventsActionSheet()
//    }
//}
