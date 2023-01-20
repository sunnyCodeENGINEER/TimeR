//
//  TestHomeView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import SwiftUI

struct TestHomeView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
//    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var reminders: FetchedResults<Reminder>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var reminders: FetchedResults<Reminder>
    
    @State private var showingAddView = false
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(reminders) { reminder in
                        NavigationLink(destination: TestEditReminderView(reminder: reminder)) {
                            HStack {
                                VStack(alignment: .leading, spacing: 6) {
                                    Text(reminder.title!)
                                        .bold()
                                    
                                    
                                }
                                Spacer()
                                Text(calcTimeSince(date: reminder.date!))
                                    .foregroundColor(.gray)
                                    .italic()
                            }
                        }
                    }
                    .onDelete(perform: deleteReminder)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Reminders")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingAddView.toggle()
                    } label: {
                        Label("Add Reminder", systemImage: "plus.circle")
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddReminderView()
            }
        }
    }
    private func deleteReminder(offsets: IndexSet) {
        withAnimation {
            offsets.map { reminders[$0]}.forEach(managedObjectContext.delete)
            
            DataController().save(context: managedObjectContext)
        }
    }
}

struct TestHomeView_Previews: PreviewProvider {
    static var previews: some View {
        TestHomeView()
    }
}

struct MyPage: View {
    var title: String
    
    var body: some View {
        Text(title)
    }
}
