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

//struct UpcomingEventCard_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingEventCard(reminder: .init())
//    }
//}

struct FirstUpcomingEvent: View {
    var reminder: FetchedResults<Reminder>.Element
    
    var body: some View {
        HStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                Text("\(reminder.title!)")
                    .font(.largeTitle)
                VStack(alignment: .leading) {
                    Text("\((reminder.date?.formatted(date: .numeric, time: .standard))!)")
                        .italic()
                    Text("\(calcTimeSince(date:reminder.date!))")
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
            .background(Image(systemName: "map.fill")
                .resizable()
                .scaledToFit()
                .frame(width: UIScreen.main.bounds.width * 0.86, height: 150)
                .offset(x: 60, y: 20)
                .rotationEffect(Angle(degrees: -45))
                .opacity(0.3)
                .clipShape(RoundedRectangle(cornerRadius: 10)))
            .overlay(RoundedRectangle(cornerRadius: 10)
                .stroke(lineWidth: 3)))
        
        .padding([.horizontal, .top])
    }
}

struct NextUpcomingEvents: View {
    var reminder: FetchedResults<Reminder>.Element
    
    var body: some View {
            HStack {
                    VStack(alignment: .leading) {
                        Text("\(reminder.title!)")
                            .font(.largeTitle)
                        VStack {
                            Text("\((reminder.date?.formatted(date: .omitted, time: .standard))!)")
                                .italic()
                            Text("\((reminder.date?.formatted(date: .numeric, time: .omitted))!)")
                        }
                        Text("\(reminder.location ?? String("no location"))")
                            .italic()
                    }
//                    .padding()
                    .frame(width: 150, height: 120)
                    .background(RoundedRectangle(cornerRadius: 10)
                        .fill(.thinMaterial)
                        .overlay(RoundedRectangle(cornerRadius: 10)
                            .stroke(lineWidth: 2)))
                    
                    .padding([.bottom, .trailing])
                }
        
    }
}
