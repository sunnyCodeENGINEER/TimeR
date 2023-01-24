//
//  CircularSliderViewTest.swift
//  TimeR
//
//  Created by Emmanuel Donkor on 24/01/2023.
//

import SwiftUI

struct CircularSliderViewTest: View {
    var body: some View {
        CircularSliderView5()
    }
}

struct CircularSliderViewTest_Previews: PreviewProvider {
    static var previews: some View {
        CircularSliderViewTest()
    }
}

struct CircularSliderView5: View {
    @State var progress1 = 0.75
    @State var progress2 = 37.5
    @State var progress3 = 7.5
    
    var body: some View {
        ZStack {
            Color(hue: 0.58, saturation: 0.06, brightness: 1.0)
                .edgesIgnoringSafeArea(.all)

            VStack {
                CircularSliderView(value: $progress1)
                    .frame(width:250, height: 250)
                
                HStack {
                    CircularSliderView(value: $progress2, in: 32...50)

                    CircularSliderView(value: $progress3, in: 0...100)
                }
                
                Spacer()
            }
            .padding()
        }
    }
}
