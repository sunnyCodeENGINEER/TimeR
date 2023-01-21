//
//  UpcomingEventCard.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import SwiftUI

struct UpcomingEventCard: View {
    @State var testArray: [Reminder] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("UPCOMING EVENTS".uppercased())
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("TITLE")
                        .font(.largeTitle)
                    HStack {
                        Text("time")
                            .italic()
                        Image(systemName: "circle.fill")
                        Text("date")
                    }
                }
                
                Spacer()
                
                VStack {
                    Image("LocationPinLight")
                        .resizable()
                    Text("location")
                        .italic()
                }
                .frame(width: 120, height: 150)
                .aspectRatio(contentMode: .fit)
                
            }
            .offset(y: -50)
            .padding()
            .frame(width: 400, height: 150)
            .background(RoundedRectangle(cornerRadius: 10)
                .foregroundColor(.blue.opacity(0.3))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(lineWidth: 5)))
            
            .padding()
            ScrollView(.horizontal) {
                HStack {
                    ForEach(0..<50) { _ in
                        VStack(alignment: .leading) {
                            Text("TITLE")
                                .font(.largeTitle)
                            HStack {
                                Text("time")
                                    .italic()
                                Image(systemName: "circle.fill")
                                Text("date")
                            }
                            Text("location")
                                .italic()
                        }
                        .padding()
                        .frame(width: 150, height: 120)
                        .background(RoundedRectangle(cornerRadius: 10)
                            .foregroundColor(.blue.opacity(0.3))
                            .overlay(RoundedRectangle(cornerRadius: 10)
                                .stroke(lineWidth: 5)))
                        
                        .padding()
                    }
                }
            }
            HStack {
                Spacer()
                Button {
                    
                } label: {
                    HStack {
                        Text("Show All")
                        Image(systemName: "chevron.right")
                    }
                    .padding(.trailing)
                }
            }
        }
        
    }
}

struct UpcomingEventCard_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingEventCard()
    }
}
