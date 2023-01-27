//
//  AddReminderView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var summary: String = ""
    @State private var date = Date.now
    @State private var shouldRepeat: Bool = false
    
    var body: some View {
        Form {
            Section {
                VStack(alignment: .leading) {
                    Text("Title")
                    TextField("Title", text: $title)
                }
                .padding()
                VStack(alignment: .leading) {
                    Text("Description")
                    TextField("Description", text: $summary)
                }
                .padding()
                VStack(alignment: .leading) {
                    DatePicker("Date", selection: $date, in: Date()...)
                }
                .padding()
                
                Toggle("Repeat", isOn: $shouldRepeat)
                    .background(.gray.opacity(0.3))
                HStack {
                    Spacer()
                    Button {
                        DataController().addReminder(title: title, summary: summary, date: date, shouldRepeat: shouldRepeat, context: managedObjectContext)
                        dismiss()
                    } label: {
                        Text("Submit".uppercased())
                            .font(.title)
                    }
                    Spacer()
                }
            }
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}
