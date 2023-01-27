//
//  UpcomingEventView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 23/01/2023.
//

import SwiftUI

struct UpcomingEventView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]) var reminders: FetchedResults<Reminder>
    
    @State private var showingAddView = false
    @State private var showActionSheet: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {        
        NavigationStack {
            List {
                ForEach(self.reminders.indices, id: \.self) { index in
                    if index == 0 {
                        NavigationLink(destination: EditReminderView(reminder: reminders[index])) {
                            FirstUpcomingEvent(reminder: reminders[index])
                                .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                    Button {
                                        managedObjectContext.delete(reminders[index])
                                        
                                        DataController().save(context: managedObjectContext)
                                    } label: {
                                        Image(systemName: "trash.fill")
                                    }
                                    .tint(.red)
                                }
                                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                    Button {
                                        
                                    } label: {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                }
                                .tint(.green)
                        }
                    }
                }
                .padding()
                    
                ScrollView(.horizontal) {
                    HStack(spacing: 5) {
                        ForEach(self.reminders.indices, id: \.self) { index in
                            if index != 0 {
                                NavigationLink(destination: EditReminderView(reminder: reminders[index])) {
                                    NextUpcomingEvents(reminder: reminders[index])
                                        .tint(Color("myBlack"))
                                }
                            }
                        }
                    }
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
