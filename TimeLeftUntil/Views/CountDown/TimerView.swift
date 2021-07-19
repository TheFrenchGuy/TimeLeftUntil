//
//  TimerView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 18/07/2021.
//

import Foundation
import SwiftUI


struct TimerView: View {
    var body: some View{
        VStack {
            Text("Let the time roll away ?🚴‍♀️").font(.title)
                .padding()
            
            CountDown()
        }
    }
}
