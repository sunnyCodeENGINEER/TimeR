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
                  , predicate: NSPredicate(format: "shouldRepeat = true", "completed = false")) var reminders: FetchedResults<Reminder>
    @FetchRequest(sortDescriptors: [SortDescriptor(\.completed), SortDescriptor(\.date)]
                  , predicate: NSPredicate(format: "shouldRepeat = false", "completed = false")) var todos: FetchedResults<Reminder>
    
    @State private var eventsDue: [Reminder] = []
    @State private var todoDue: [Reminder] = []
    @State private var showingAddView = false
    @State private var showActionSheet: Bool = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundView()
                
                VStack {
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
                        .listRowBackground(Color.clear)
                        .padding([.leading, .top])
                        
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
                        .ignoresSafeArea()
                        .listRowBackground(Color.clear)
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
                    .listStyle(.plain)
                    .background(.clear)
                
                
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
                    .listRowBackground(Color.clear)
                }
                .listStyle(.plain)
                }
                .background(Color.clear)
            }
            .background(Color.clear)
        
    }
        .onReceive(self.timer) { value in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "HH:mm:ssa"
            let newDayCheck = (dateFormatter.date(from: "12:00:00am")?.formatted(date: .omitted, time: .standard)) ?? Date().formatted(date: .omitted, time: .standard)
            if Date().formatted(date: .omitted, time: .standard) == newDayCheck {
                eventsDue.removeAll()
                todoDue.removeAll()
            }
            todos.forEach { todo in
                if Int(systemCalcTimeSince2(date: todo.date!)) ?? 1 < 0 {
                    if !todo.completed {
                        DataController().editReminder(reminder: todo, title: todo.title!, summary: todo.summary!, date: todo.date ?? Date(), shouldRepeat: todo.shouldRepeat, frequency: todo.frequency ?? "daily", completed: todo.completed, skipped: true, context: managedObjectContext)
                        todoDue.append(todo)
                    } else {
                        managedObjectContext.delete(todo)
                        
                        DataController().save(context: managedObjectContext)
                    }
                }
            }
            todos.forEach { todo in
                if Int(systemCalcTimeSince2(date: todo.date!)) ?? 1 < -600 {
                    managedObjectContext.delete(todo)
                    
                    DataController().save(context: managedObjectContext)
                }
            }
            reminders.forEach { reminder in
                if Int(systemCalcTimeSince(date: reminder.date!)) ?? 1 < 0 {
                    eventsDue.append(reminder)
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
