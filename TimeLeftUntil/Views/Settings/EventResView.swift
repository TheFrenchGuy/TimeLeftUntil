//
//  EventResView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 18/07/2021.
//

import SwiftUI

struct EventResView: View {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @ObservedObject var userPreference = UserPreference()
    
    
    var resolutionplaceEvent = ["2 d.p", "3 d.p", "4 d.p", "5 d.p", "6 d.p"]
    @State private var selectedResEvent = 0
    @State var TestEvent:Double = 26.015833
    @State var test: String = "26.015833"
    
    var body: some View {
        VStack {
            Text("\(test) hours").frame(width: 350, alignment: .center)
            
            Picker(selection: $selectedResEvent, label: Text("Decimal Places")) {
              ForEach(0..<resolutionplaceEvent.count) {
                Text(resolutionplaceEvent[$0])
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: self.selectedResEvent) {newValue in
                switch (selectedResEvent) {
                case 0:
                    delegate.eventres = "%.2f"
                case 1:
                    delegate.eventres = "%.3f"
                case 2:
                    delegate.eventres = "%.4f"
                case 3:
                    delegate.eventres = "%.5f"
                case 4:
                    delegate.eventres = "%.6f"
                default:
                    delegate.eventres = "%"
                    print("CASE ERROR")
                }
                test = String(format: delegate.eventres, TestEvent)
                
            
            }
        
        }.onAppear(perform: {testEvent()})
            .frame(width: 350)
    }
    
    func testEvent() {
        let diff = Date().addingTimeInterval(93657).timeIntervalSince(Date())
        let testtime = Double(diff) / 3600
        TestEvent = testtime
    }
}

struct EventResView_Previews: PreviewProvider {
    static var previews: some View {
        EventResView()
    }
}
