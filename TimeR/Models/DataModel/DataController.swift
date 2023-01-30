//
//  DataController.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import Foundation
import CoreData

class DataController: ObservableObject {
    let container = NSPersistentContainer(name: "ReminderModel")
    
    init() {
        container.loadPersistentStores { desc, error in
            if let error = error {
                print("Failed to load data.: \(error.localizedDescription)")
            }
        }
    }
    
    func save(context: NSManagedObjectContext) {
        do {
            try context.save()
            print("data saved successfully")
        } catch {
            print("data was not able to be saved")
        }
    }
    
    func addReminder(title: String, summary: String, date: Date, shouldRepeat: Bool, frequency: String = "daily", context: NSManagedObjectContext) {
        let reminder = Reminder(context: context)
        reminder.id = UUID()
        reminder.date = date
        reminder.title = title
        reminder.summary = summary
        reminder.shouldRepeat = shouldRepeat
        reminder.frequency = frequency
        
        save(context: context)
    }
    
    func editReminder(reminder: Reminder, title: String, summary: String, date: Date, shouldRepeat: Bool, frequency: String, completed: Bool, context: NSManagedObjectContext) {
        reminder.title = title
        reminder.summary = summary
        reminder.date = date
        reminder.shouldRepeat = shouldRepeat
        reminder.completed = completed
        reminder.frequency = frequency
        
        save(context: context)
    }
}
