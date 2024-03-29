//
//  TodoListView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 20/01/2023.
//

import SwiftUI

struct TodoListView: View {
    var reminder: FetchedResults<Reminder>.Element
//    @Binding var isCompleted: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Image(systemName: reminder.completed ? "circle.fill" : "circle")
                    .resizable()
                    .foregroundColor(reminder.completed ? .green : .black)
                    .frame(width: 20, height: 20)
                    .scaledToFit()
                    .padding()
                VStack(alignment: .leading) {
                    Text("\(reminder.title!)")
                    Text("\(reminder.summary!)")
                }
                Spacer()
                Text("\(calcTimeSince(date:reminder.date!))")
                    .font(.footnote)
                    .italic()
                    .foregroundColor(.gray)
                    .padding(.trailing)
            }
            .padding()
            .frame(width: 400, height: 80)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.thinMaterial)
                .shadow(radius: 5)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 2)))
            
            .padding(.horizontal)
        }
    }
}
