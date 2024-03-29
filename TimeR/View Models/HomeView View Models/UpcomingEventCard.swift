//
//  UpcomingEventCard.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import SwiftUI

struct UpcomingEventCard: View {
    var reminder: FetchedResults<Reminder>.Element
    @State var testArray: [Reminder] = []
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("UPCOMING EVENTS".uppercased())
                .font(.title2)
                .fontWeight(.bold)
                .padding()
            
            FirstUpcomingEvent(reminder: reminder)
            
            NextUpcomingEvents(reminder: reminder)
            
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

struct FirstUpcomingEvent: View {
    var reminder: FetchedResults<Reminder>.Element
    
    var body: some View {
        ZStack {
            HStack(alignment: .bottom) {
                VStack(alignment: .leading) {
                    Text("\(reminder.title!)")
                        .font(.largeTitle)
                    VStack(alignment: .leading) {
                        Text("\((reminder.date?.formatted(date: .numeric, time: .standard))!)")
                            .italic()
                        Text("\(calcTimeSince(date:reminder.date!))")
                            .font(.footnote)
                            .italic()
                            .foregroundColor(.gray)
                            .padding(.trailing)
                    }
                }
                
                Spacer()
                
                VStack {
                    Image("LocationPinLight")
                        .resizable()
                    Text("\(reminder.location ?? String("no location"))")
                        .italic()
                }
                .frame(width: 120, height: 150)
                .aspectRatio(contentMode: .fit)
                
            }
            .offset(y: -40)
            .padding()
            .frame(width: UIScreen.main.bounds.width * 0.86, height: 150)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.thinMaterial)
                .shadow(radius: 5)
                .background(Image(systemName: "map.fill")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width * 0.86, height: 150)
                    .offset(x: 60, y: 20)
                    .rotationEffect(Angle(degrees: -45))
                    .opacity(0.3)
                    .clipShape(RoundedRectangle(cornerRadius: 10)))
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 3)))
            .padding([.horizontal, .top])
            
            if reminder.completed {
                VStack {
                    HStack {
                        Circle()
//                        Image(systemName: "circle.fill")
                            .foregroundColor(.green)
                            .frame(width: 20, height: 20)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 15)
                        
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width * 0.86, height: 150)
            }
        }
    }
}

struct NextUpcomingEvents: View {
    var reminder: FetchedResults<Reminder>.Element
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("\(reminder.title!)")
                    .font(.title)
                VStack(alignment: .leading) {
                    Text("\((reminder.date?.formatted(date: .omitted, time: .standard))!)")
                        .font(.footnote)
                        .italic()
                    Text("\((reminder.date?.formatted(date: .numeric, time: .omitted))!)")
                        .font(.footnote)
                }
                Text("\(reminder.location ?? String("no location"))")
                    .font(.footnote)
                    .italic()
            }
            .frame(width: 150, height: 120)
            .background(RoundedRectangle(cornerRadius: 10)
                .fill(.thinMaterial)
                .shadow(radius: 3)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 3)))
            
            .padding([.bottom, .trailing])
            .padding(.bottom, 3)
            
            if reminder.completed {
                VStack {
                    HStack {
                        Circle()
                            .foregroundColor(.green)
                            .frame(width: 20, height: 20)
                        
                        Spacer()
                    }
                    Spacer()
                }
                .frame(width: 150, height: 120)
            }
                
        }
    }
}
