//
//  GettingOlderView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 06/07/2021.
//

import SwiftUI


struct GettingOlderView: View {
   
    
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userPreference = UserPreference()
    
    
    @State private var selected: Bool = false
  
    var body: some View {
        
        ZStack {
            if !selected {
                LazyVStack(alignment: .center) {
                    Text("So when are you born ? 👉👈").padding(5).font(.title)
                    
                    HStack {
                        VStack(alignment: .leading) {
                            DatePicker("Birthdate", selection:$userPreference.birthdate, displayedComponents: [.date] ) .datePickerStyle(CompactDatePickerStyle())
                                .labelsHidden()
                                .frame(width: 120)
                            
                            
                            DatePicker("BirthDate", selection: $userPreference.birthdate, displayedComponents: [.date])
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .foregroundColor(.blue)
                            .labelsHidden()
                            .frame(width: 120)
                            
                        }.padding()
                        
                        Divider()
                            .background(colorScheme == .dark ? Color.white : Color.black)
                            
                        
                        VStack {
                            Text("🎂").font(.system(size: 48))
                            Text("Start time on earth:")
                            Text("\(userPreference.birthdate, style: .date)")
                        }.padding()
                    }
                    
                    
                    Button(action: {
                        selected.toggle()
                        userPreference.setChoice = 1
                        
                        UserDefaults.standard.set(1, forKey: "setChoice") // This means that the user is logging in the first time so he must complete the daily intake calculator
                        NotificationCenter.default.post(name: NSNotification.Name("setChoice"), object: nil) //Put a backend notification to inform app the data has been written
                    }) {
                        Text("Start counting")
                    }.padding()
                    
                }.frame(width: 360)
            } else {
                ConfirmationView(selected: self.$selected, TextCustom: "Calculating how much older your getting", LottieViewName: "cloudSyncAnimation", notificationTitle: "Getting younger failed", notificationSub: "Looks like it is going in the wrong direction")
            }
            
        }
    }
}

struct GettingOlderView_Previews: PreviewProvider {
    static var previews: some View {
        GettingOlderView()
    }
}
