//
//  YearsResView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 18/07/2021.
//

import SwiftUI

struct YearsResView: View {
    
    @ObservedObject var userPreference = UserPreference()
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    
    var resolutionplaceBirth = ["6 d.p", "7 d.p", "8 d.p"]
    @State private var selectedResBirth = 0
    @State var Yearsold:Double = 0.0
    
    
    var body: some View {
        
        VStack {
            Text("\(String(format: delegate.birthdayres, Yearsold)) years").frame(width: 350, alignment: .center)
            
            
            Picker(selection: $selectedResBirth, label: Text("Decimal Places")) {
              ForEach(0..<resolutionplaceBirth.count) {
                Text(resolutionplaceBirth[$0])
              }
            }
            .pickerStyle(SegmentedPickerStyle())
            .onChange(of: self.selectedResBirth) {newValue in
                switch (selectedResBirth) {
                case 0:
                    delegate.birthdayres = "%.6f"
                case 1:
                    delegate.birthdayres = "%.7f"
                case 2:
                    delegate.birthdayres = "%.8f"
                default:
                    delegate.birthdayres = "%"
                    print("CASE ERROR")
                }
                
                timeBirthday()
            }
            
        }.onAppear(perform: {timeBirthday(); onAppearTimeBirthday()})
            .frame(width: 350)
    }
    
    
    func timeBirthday() {
            let time = Date().timeIntervalSince(userPreference.birthdate)
            let yearsold = Double(time) / 31557600
            Yearsold = yearsold
    }
    
    func onAppearTimeBirthday() {  //so that it loads the correct possition on the slider from memory 
        switch (delegate.birthdayres) {
            case "%.6f" :
                selectedResBirth = 0
            case "%.7f" :
                selectedResBirth = 1
            case "%.8f" :
                selectedResBirth = 2
            default:
                    selectedResBirth = 0
                    print("CASE ERROR")
            
        }
    }
    
    func setInitalState() {
        
    }
}


struct YearsResView_Previews: PreviewProvider {
    static var previews: some View {
        YearsResView()
    }
}
