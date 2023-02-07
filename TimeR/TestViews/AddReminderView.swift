//
//  AddReminderView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 19/01/2023.
//

import SwiftUI

struct AddReminderView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title: String = ""
    @State private var summary: String = ""
    @State private var date = Date.now
    @State private var shouldRepeat: Bool = false
    @State private var frequency: String = "daily"
    
    var body: some View {
        ZStack {
            Form {
                Section {
                    VStack(alignment: .leading) {
                        Text("Title")
                            .labelModifier()
                        TextField("Title", text: $title)
                            .inputFieldModifier()
                    }
                    .sectionModifier()
                    
                    VStack(alignment: .leading) {
                        Text("Description")
                            .labelModifier()
                        TextField("Description", text: $summary)
                            .inputFieldModifier()
                    }
                    .sectionModifier()
                    
                    VStack(alignment: .leading) {
                        DatePicker("Date", selection: $date, in: Date()...)
                    }
                    .padding()
                    
                    Toggle("Repeat", isOn: $shouldRepeat)
                        .padding(.horizontal)
                        .background(.gray.opacity(0.3))
                        .cornerRadius(10)
                    if shouldRepeat {
                        Picker("Pick a frequency", selection: $frequency) {
                            Text("daily").tag("daily")
                            Text("weekly").tag("weekly")
                            Text("monthly").tag("monthly")
                            Text("yearly").tag("yearly")
                        }
                        .animation(.easeInOut, value: shouldRepeat)
                    }
                    HStack {
                        Spacer()
                        Button {
                            DataController().addReminder(title: title, summary: summary, date: date, shouldRepeat: shouldRepeat, frequency: frequency, context: managedObjectContext)
                            dismiss()
                        } label: {
                            Text("Submit")
                                .submitButtonModifier()
                        }
                        Spacer()
                    }
                }
                .background(.clear)
            }
            
            Image(systemName: "plus.circle")
                .resizable()
                .scaledToFit()
                .opacity(0.2)
                .position(x: 100, y : 150)
        }
    }
}

struct AddReminderView_Previews: PreviewProvider {
    static var previews: some View {
        AddReminderView()
    }
}

struct LabelViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5.0)
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(.thinMaterial)
                .shadow(radius: 3)
                .overlay(RoundedRectangle(cornerRadius: 10)
                    .stroke(.white, lineWidth: 3)))
    }
}

struct InputFieldViewModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding(5)
            .background(RoundedRectangle(cornerRadius: 15)
                .fill(.thickMaterial))
    }
}

struct SectionViewModifier: ViewModifier {
    @EnvironmentObject var colorScheme: TimeColorScheme
    
    func body(content: Content) -> some View {
        content
            .padding()
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme.color4)
                .shadow(radius: 3)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 3)))
    }
}

struct SubmitButtonViewModifier: ViewModifier {
    @EnvironmentObject var colorScheme: TimeColorScheme
    
    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .padding()
            .background(RoundedRectangle(cornerRadius: 20)
                .fill(colorScheme.color5)
                .shadow(radius: 10, x: 10, y: 10)
                .overlay(RoundedRectangle(cornerRadius: 20)
                    .stroke(.white, lineWidth: 3)))
            .tint(Color("myWhite"))
    }
}

extension View {
    func labelModifier() -> some View {
        modifier(LabelViewModifier())
    }
    
    func inputFieldModifier() -> some View {
        modifier(InputFieldViewModifier())
    }
    
    func sectionModifier() -> some View {
        modifier(SectionViewModifier())
    }
    
    func submitButtonModifier() -> some View {
        modifier(SubmitButtonViewModifier())
    }
}
