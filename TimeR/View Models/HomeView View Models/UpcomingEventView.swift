//
//  UpcomingEventView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 23/01/2023.
//

import SwiftUI

struct UpcomingEventView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]
                  , predicate: NSPredicate(format: "shouldRepeat = true")) var reminders: FetchedResults<Reminder>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.date)]
                  , predicate: NSPredicate(format: "shouldRepeat = false")) var todos: FetchedResults<Reminder>
    
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
                .padding([.leading, .top])
                
                ScrollView(.horizontal) {
                    HStack(spacing: 5) {
                        Spacer(minLength: 5)
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
            Text("TODO")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
                
            List {
                ForEach(self.todos) { item in
                    NavigationLink(destination: EditReminderView(reminder: item)) {
                        TodoListView(reminder: item)
                            .padding(.leading)
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button {
                                    managedObjectContext.delete(item)
                                    
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
                                .tint(.green)
                            }
                    }
                }
            }
            .listStyle(.plain)
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
