//
//  SettingsView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 06/07/2021.
//

import SwiftUI
import LaunchAtLogin
import UserNotifications
import librlottie
import Combine




struct SettingsView: View {
    
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate

    //@State var test = ""
    @ObservedObject var userPreference = UserPreference()
    //@State var testToggle = true
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                
                LaunchAtLogin.Toggle { // To let the application start at login
                    Text("Launch Application at Login?")
                }
                    .padding(.top, 10)
                    .padding(.leading, 5)
                
                
                Toggle(isOn: $userPreference.showNotifications) {
                    Text("Show notification on timers end?")
                }.onChange(of: userPreference.showNotifications) { newValue in
                    
                    if userPreference.showNotifications {
                        delegate.showNotificationAtTimersEnd = true
                        let content = UNMutableNotificationContent()
                        content.title = "When the timer ends then it will be displayed there"
                        content.subtitle = "It looks like your hungry to know when it is completed"
                        content.sound = UNNotificationSound.default

                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                        
                    } else {
                        delegate.showNotificationAtTimersEnd = false
                    }
                }.padding(.vertical, 10)
                    .padding(.leading, 5)
                
                
                Divider().frame(width: 340, alignment: .center)
                
                
                
                EventResView()
               
                YearsResView()
                
                Divider().frame(width: 340, alignment: .center)
                
                
                Button(action: {
                    NSApplication.shared.terminate(self)
                })
                {
                    Text("Quit App")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .frame(width: 330, alignment: .center)
                }
                
                
                Divider()
                
                Button(action: {
                    //To show about me page
                    
                    delegate.showAboutMe = true
                    
                    
                    NSApp.activate(ignoringOtherApps: true)
                    NSApp.orderFrontStandardAboutPanel()
                    
                    
                }) {
                    
                    VStack {
                    Image("Icon-MacOS").resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 350, height: 70 , alignment: .center)
                    }
                    
                }.buttonStyle(.borderless)

                
                
                
                
                
            }
        }.frame(width: 350)
    }
    
    
    
    
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}


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
            
        }.onAppear(perform: {timeBirthday()})
            .frame(width: 350)
    }
    
    
    func timeBirthday() {
            let time = Date().timeIntervalSince(userPreference.birthdate)
            let yearsold = Double(time) / 31557600
            Yearsold = yearsold
    }
}
