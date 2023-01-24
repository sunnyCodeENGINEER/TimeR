//
//  EditReminderTitleField.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 24/01/2023.
//

import SwiftUI

struct EditReminderTitleField: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var reminder: FetchedResults<Reminder>.Element
    
    @State private var title = ""
    @State private var summary = ""
    @State private var date = Date()
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("Title".uppercased())
                        .font(.title)
                        .fontWeight(.bold)
                    TextField("\(reminder.title!)", text: $title)
                        .onAppear {
                            title = reminder.title!
                            summary = reminder.summary!
                            date = reminder.date!
                        }
                }
            }
            Section {
                VStack(alignment: .leading) {
                    Text("Description")
                        .font(.title)
                        .fontWeight(.bold)
                    TextField("\(reminder.summary!)", text: $summary)
                }
            }
        }
    }
}

//struct EditReminderTitleField_Previews: PreviewProvider {
//    static var previews: some View {
//        EditReminderTitleField()
//    }
//}
