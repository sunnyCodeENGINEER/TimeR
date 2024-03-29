//
//  ContentView.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 17/01/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var colorScheme: TimeColorScheme = TimeColorScheme()
    
    var body: some View {
        VStack {
            MainAppView()
//            BackgroundView()
//            UpcomingEventView()
//            TestHomeView()
//            BackgroundNightSkyOverlay()
                .environmentObject(colorScheme)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
