//
//  TodoDataController.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 27/01/2023.
//

import Foundation
import CoreData

class TodoDataController: ObservableObject {
    let todoContainer = NSPersistentContainer(name: "TodoModel")
    
    init() {
        todoContainer.loadPersistentStores { desc, error in
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
    
    func addTodo(title: String, summary: String, date: Date, shouldRepeat: Bool, context: NSManagedObjectContext) {
//        let todo = Todo(context: context)
//        todo.id = UUID()
//        todo.date = date
//        todo.title = title
//        todo.summary = summary
//        todo.shouldRepeat = shouldRepeat
        
        save(context: context)
    }
    
//    func editTodo(todo: Todo, title: String, summary: String, date: Date, shouldRepeat: Bool, completed: Bool, context: NSManagedObjectContext) {
//        todo.title = title
//        todo.summary = summary
//        todo.date = date
//        todo.shouldRepeat = shouldRepeat
//        todo.completed = completed
//
//        save(context: context)
//    }
}

