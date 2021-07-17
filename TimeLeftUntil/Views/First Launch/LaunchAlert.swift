//
//  LaunchAlert.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 09/07/2021.
//

import Cocoa
import SwiftUI


struct LaunchAlert: NSViewRepresentable {
    
    let view = NSView()
 
    func makeNSView(context: Context) -> some NSView {
                let dialogMessage = NSAlert()
        dialogMessage.alertStyle = .informational
        dialogMessage.messageText = "Thank you for installing TimeLeftUntil"
        dialogMessage.informativeText =  """
This app is designed to do 3 things, (well maybe more but not intenotially),1. remind you that you are getting older so you are being more productive and doing more of your time here with us on earth, 2. Let you know how much time you have left until an event is/ a project is due/ or even when should you go outside your house. 3. The most boring features of this app but I mean it works well, the countdown, lets say you... well I really shouldn't explain this to you.

    Who is the developer is this amazing app. Well its Noe de La Croix. @TheFrenchGuyFr on Twitter. I am 18 years old and I guess I am just starting my computer science carrer. About to go uni and decided to do a short week project to code during the 2021 summer. If you find anything wrong with the app or you want an extra features feel free to contact me, could always use some advice.


    A bit more about the app, designed using xCode 13 and using swiftUI for all of the main views except maybe a few, the code is available in open source on github, feel once again free to have a look there. By using the app I assume that you have agreed with the terms and conditions (available under the settings tap and then click on the icon)
"""
        dialogMessage.addButton(withTitle: "Okay I'll start using the app")
        dialogMessage.accessoryView = NSView(frame: NSMakeRect(0, 0, 500, 0))
        dialogMessage.runModal()
        
        //view.window?.contentViewController = NSViewController()
        
        return view
    }
    
    func updateNSView(_ nsView: NSViewType, context: Context) {
        
        
    }
}
