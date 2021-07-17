//
//  ConfirmationView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 07/07/2021.
//

import SwiftUI
import UserNotifications


struct ConfirmationView: View {
    
    @ObservedObject var userPreference = UserPreference()
    
    @Binding var selected:Bool
    
    
    var TextCustom:String
    var LottieViewName: String
    
    
    var notificationTitle: String
    var notificationSub: String
    
    var body: some View {
        VStack {
            LottieView(filename: LottieViewName, speed: 1.0, loop: .loop, heightView: 250, widthView: 250).frame(width: 250, height: 250)
            
            Text(TextCustom)
            
        
            
            
        }.frame(width: 360)
            .onAppear(perform: {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    withAnimation(.easeIn) {
                        selected = false
                    }
                    
                    
                })
            })
        
            .onDisappear(perform: {
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                    withAnimation(.easeIn) {
                        let content = UNMutableNotificationContent()
                        content.title = notificationTitle
                        content.subtitle = notificationSub
                        content.sound = nil

                        // show this notification five seconds from now
                        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

                        // choose a random identifier
                        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
                        
                        

                        // add our notification request
                        UNUserNotificationCenter.current().add(request)
                        
                        
                        
                        
                        
                    }
                    
                    NotificationCenter.default.post(name: NSNotification.Name(rawValue: "update") , object: nil)
                    
                    
                    
                    
                    
                })
                                    NSApplication.shared.hide(nil)
                ///Solution found there  https://stackoverflow.com/questions/30923271/mac-how-to-programmatically-hide-nsapplicationactivationpolicyaccessory-or-lsu
            })
    }
}

struct SelectedGettingOlderView_Previews: PreviewProvider {
    static var previews: some View {
        ConfirmationView(selected: .constant(true), TextCustom: "Calculating how much older your getting", LottieViewName: "cloudSyncAnimation", notificationTitle: "Getting younger failed", notificationSub: "Looks like it is going in the wrong direction")
    }
}
