//
//  TodoListView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 20/01/2023.
//

import SwiftUI

struct TodoListView: View {
    var body: some View {
        VStack(alignment: .leading) {
            Text("TODO")
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            ScrollView(.vertical) {
                ForEach(0..<50) { _ in
                    HStack {
                        Image(systemName: "checkmark")
                            .resizable()
                            .frame(width: 30, height: 25)
                            .scaledToFit()
                            .padding()
                        VStack(alignment: .leading) {
                            Text("TITLE")
                            Text("Description goes here...")
                        }
                        Spacer()
                    }
                    .padding()
                    .frame(width: 400, height: 80)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .foregroundColor(.blue.opacity(0.3))
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)))
                    
                    .padding(.horizontal)
                }
            }
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TodoListView()
    }
}

