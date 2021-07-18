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
                    .keyboardShortcut("a", modifiers: .command)

                
                
                
                
                
            }
        }.frame(width: 350)
    }
    
    
    
    
    
    
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}





