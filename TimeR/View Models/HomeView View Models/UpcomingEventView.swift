//
//  UpcomingEventView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 23/01/2023.
//

import SwiftUI

struct UpcomingEventView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(sortDescriptors: [SortDescriptor(\.completed), SortDescriptor(\.date)]
                  , predicate: NSPredicate(format: "shouldRepeat = true")) var reminders: FetchedResults<Reminder>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.completed), SortDescriptor(\.date)]
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
                            ZStack {
                                FirstUpcomingEvent(reminder: reminders[index])
                            }
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
                                if !reminders[index].completed {
                                    Button {
                                        DataController().editReminder(reminder: reminders[index], title: reminders[index].title!, summary: reminders[index].summary!, date: reminders[index].date!, shouldRepeat: reminders[index].shouldRepeat, frequency: reminders[index].frequency ?? "daily", completed: true, context: managedObjectContext)
                                        
                                    } label: {
                                        Image(systemName: "checkmark.circle.fill")
                                    }
                                    .tint(.green)
                                } else {
                                    Button {
                                        DataController().editReminder(reminder: reminders[index], title: reminders[index].title!, summary: reminders[index].summary!, date: reminders[index].date!, shouldRepeat: reminders[index].shouldRepeat, frequency: reminders[index].frequency ?? "daily", completed: false, context: managedObjectContext)
                                        
                                    } label: {
                                        Image(systemName: "x.circle.fill")
                                    }
                                    .tint(.red)
                                }
                            }
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
                        ZStack {
                            TodoListView(reminder: item)
                        }
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
                            if !item.completed {
                                Button {
                                    DataController().editReminder(reminder: item, title: item.title!, summary: item.summary!, date: item.date!, shouldRepeat: item.shouldRepeat, frequency: item.frequency ?? "daily", completed: true, context: managedObjectContext)
                                } label: {
                                    Image(systemName: "checkmark.circle.fill")
                                }
                                .tint(.green)
                            } else {
                                Button {
                                    DataController().editReminder(reminder: item, title: item.title!, summary: item.summary!, date: item.date!, shouldRepeat: item.shouldRepeat, frequency: item.frequency!, completed: false, context: managedObjectContext)
                                } label: {
                                    Image(systemName: "x.circle.fill")
                                }
                                .tint(.red)
                            }
                        }
                    }
                }
            }
            .listStyle(.plain)
        }
        .onReceive(self.timer) { value in
            todos.forEach { todo in
                if Int(systemCalcTimeSince(date: todo.date!)) ?? 1 < 0 {
                    managedObjectContext.delete(todo)
                    
                    DataController().save(context: managedObjectContext)
                }
            }
            reminders.forEach { reminder in
                if Int(systemCalcTimeSince(date: reminder.date!)) ?? 1 < 0 {
                    if reminder.frequency == "daily" {
                        var dateComponent = DateComponents()
                        dateComponent.day = 1
                        reminder.date = Calendar.current.date(byAdding: dateComponent, to: reminder.date ?? Date())
                    }
                    if reminder.frequency == "weekly" {
                        var dateComponent = DateComponents()
                        dateComponent.day = 7
                        reminder.date = Calendar.current.date(byAdding: dateComponent, to: reminder.date ?? Date())
                    }
                    if reminder.frequency == "monthly" {
                        var dateComponent = DateComponents()
                        dateComponent.month = 1
                        reminder.date = Calendar.current.date(byAdding: dateComponent, to: reminder.date ?? Date())
                    }
                    if reminder.frequency == "yearly" {
                        var dateComponent = DateComponents()
                        dateComponent.year = 1
                        reminder.date = Calendar.current.date(byAdding: dateComponent, to: reminder.date ?? Date())
                    }
                    
                    DataController().editReminder(reminder: reminder, title: reminder.title!, summary: reminder.summary!, date: reminder.date!, shouldRepeat: reminder.shouldRepeat, frequency: reminder.frequency!, completed: false, context: managedObjectContext)
                    //                    DataController().save(context: managedObjectContext)
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
