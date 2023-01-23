//
//  UpcomingEventView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 23/01/2023.
//

import SwiftUI

struct UpcomingEventView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date, order: .reverse)]) var reminders: FetchedResults<Reminder>
    
    @State private var showingAddView = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List {
                    ForEach(self.reminders.indices, id: \.self) { index in
                        NavigationLink(destination: TestEditReminderView(reminder: reminders[index])) {
                            if index == 0 {
                                FirstUpcomingEvent(reminder: reminders[index])
                            } else {
                                NextUpcomingEvents(reminder: reminders[index])
                            }
                        }
                    }
                        .onDelete(perform: deleteReminder)
                }
                .listStyle(.plain)
            }
            .navigationTitle("Upcoming Events")
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
        .onReceive(self.timer) { value in
            reminders.forEach { reminder in
                if Int(systemCalcTimeSince(date: reminder.date!)) ?? 1 < 0 {
                    managedObjectContext.delete(reminder)
                    
                    DataController().save(context: managedObjectContext)
                }
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

struct UpcomingEventView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventView()
    }
}
