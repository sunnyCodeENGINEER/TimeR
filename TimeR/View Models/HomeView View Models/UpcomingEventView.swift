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
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
//        NavigationStack {
//            ScrollView {
//                VStack(alignment: .leading) {
//                    //                List {
//                    ForEach(self.reminders.indices, id: \.self) { index in
//                        //                        NavigationLink(destination: TestEditReminderView(reminder: reminders[index])) {
//                        if index == 0 {
//                            FirstUpcomingEvent(reminder: reminders[index])
//                                .padding(.horizontal)
//                        }
//                    }
//                    .onDelete(perform: deleteReminder)
//                    //                }
//                    //                .frame(height: 180)
//                    //                .listStyle(.plain)
//
//                    ScrollView(.horizontal) {
//                        HStack {
//                            ForEach(self.reminders.indices, id: \.self) { index in
//                                if index != 0 {
//                                    NextUpcomingEvents(reminder: reminders[index])
//
//                                }
//                            }
//                        }
//                        .padding(.horizontal, 30)
//                    }
//
//                    Spacer()
//                }
//            }
//            .navigationTitle("Upcoming Events")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    Button {
//                        showingAddView.toggle()
//                    } label: {
//                        Label("Add Reminder", systemImage: "plus.circle")
//                    }
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    EditButton()
//                }
//            }
//            .sheet(isPresented: $showingAddView) {
//                AddReminderView()
//            }
//        }
        
        NavigationStack {
            List {
                VStack {
                    HStack {
                        ForEach(self.reminders.indices, id: \.self) { index in
                            if index == 0 {
                                NavigationLink(destination: TestEditReminderView(reminder: reminders[index])) {
                                    FirstUpcomingEvent(reminder: reminders[index])
                                }
                            }
                        }
                        .onDelete(perform: deleteReminder)
                    }
                    .padding()
                    
                    ScrollView(.horizontal) {
                        HStack(spacing: 5) {
                            ForEach(self.reminders.indices, id: \.self) { index in
                                if index != 0 {
                                    NavigationLink(destination: TestEditReminderView(reminder: reminders[index])) {
                                        NextUpcomingEvents(reminder: reminders[index])
                                            .padding(.leading)
                                            .tint(Color("myBlack"))
                                    }
                                }
                            }
//                            .onDelete(perform: deleteReminder)
                        }
                        .padding(.horizontal, 30)
                    }
                }
                .padding(.leading)
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
