//
//  UpcomingEventsActionSheet.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 26/01/2023.
//

import SwiftUI

struct UpcomingEventsActionSheet: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    var reminder: FetchedResults<Reminder>.Element
    
    var body: some View {
        VStack {
            Button {
                managedObjectContext.delete(reminder)
                
                DataController().save(context: managedObjectContext)
                dismiss()
            } label: {
                Text("Completed")
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 20)
                        .stroke()
                        .background(.thickMaterial))
            }
        }
    }
}
//
//struct UpcomingEventsActionSheet_Previews: PreviewProvider {
//    static var previews: some View {
//        UpcomingEventsActionSheet()
//    }
//}
