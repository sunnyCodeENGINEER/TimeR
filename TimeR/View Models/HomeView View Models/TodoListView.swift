//
//  TodoListView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 20/01/2023.
//

import SwiftUI

struct TodoListView: View {
    var reminder: FetchedResults<Reminder>.Element
    
    var body: some View {
        VStack(alignment: .leading) {
            //            Text("TODO")
            //                .font(.title2)
            //                .fontWeight(.bold)
            //                .padding()
            HStack {
                Image(systemName: "checkmark")
                    .resizable()
                    .frame(width: 30, height: 25)
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
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 2)))
            
            .padding(.horizontal)
        }
    }
}
