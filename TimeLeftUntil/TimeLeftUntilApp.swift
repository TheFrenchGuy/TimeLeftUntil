//
//  TimeLeftUntilApp.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 05/07/2021.
//

import SwiftUI
import Foundation
import Cocoa
import AppKit
import ServiceManagement
import UserNotifications

@main
struct TimeLeftUntilApp: App {
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @Environment(\.presentationMode) var presentationMode
    var body: some Scene {
//
//        WindowGroup {
//            EmptyView()
//        }
         Settings{
             EmptyView()
        }
    }
}



class TimerManager {

    var _timerTable = [Int: Timer]()
    var _id: Int = 0

    /*! Schedule a timer and return an integer that represents id of the timer
     */
    func startTimer(target: AnyObject, selector: Selector, interval: TimeInterval) -> Int {
        let timer = Timer.scheduledTimer(timeInterval: interval, target: target, selector: selector, userInfo: nil, repeats: true)
        _id += 1
        _timerTable[_id] = timer
        return _id
    }

    /*! Stop a timer of an id
    */
    func stopTimer(id: Int) {
        if let timer = _timerTable[id] {
            if timer.isValid {
                timer.invalidate()
            }
        }
    }

    /*! Returns timer instance of an id
    */
    func getTimer(id: Int) -> Timer? {
        return _timerTable[id]
    }

}




class AppDelegate: NSObject, NSApplicationDelegate {
    @Environment(\.colorScheme) var colorScheme
    let timerManager = TimerManager()
    var popover = NSPopover.init()
    var alert = NSAlert.init()
    var statusBarItem: NSStatusItem?
    var window: NSWindow?
 
    var showAboutMe: Bool = false
   
    
    var toggleNotification: Bool = false
    var showNotificationAtTimersEnd: Bool = true
    
    var eventDone: Bool = false
    
    
    
    let defaults = UserDefaults.standard
    
    //var timeLeft = UserPreference().testtimer
    
    
    @objc dynamic var birthdayres: String {
        get {
            let value = UserPreference().setResolutionBirthday
            return value
        } set {
            defaults.set(newValue, forKey: "setResolutionBirthday")
            defaults.synchronize()
        }
    }
    
    @objc dynamic var eventres: String {
        get {
            let value = UserPreference().setEventCountDownResolution
            return value
        } set {
            defaults.set(newValue, forKey: "setEventCountDownResolution")
            defaults.synchronize()
        }
    }
    
    @objc dynamic var timeLeft: Double {
        get {
            let value = UserPreference().testtimer
            return value
        } set {
            defaults.set(newValue, forKey: "testtimer")
            defaults.synchronize()
        }
    }
    
    
    @objc dynamic var isFirstLaunch: Bool {
        get {
            let value = UserPreference().firstLaunch
            return value
        } set {
            defaults.set(newValue, forKey: "firstLaunch")
            defaults.synchronize()
        }
    }
    
    
    @objc dynamic var Count: Int {
        get {
            let value = UserPreference().setChoice
            return value
        } set {
            
            defaults.set(newValue, forKey: "setChoice")
            defaults.synchronize()
    
            
        }
        
    }
    
    @objc func setCount() {
        

        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.Count == 1 {
                self.timediff()
               // self.test(invalidate: true)
               // print("CASE 1")
            } else if self.Count == 2 {
                self.timetillprojectcompletion()
               // print("CASE 2")
            } else if self.Count == 3 {
                self.test()
               
                
              //  print("CASE 3")
            } else if self.Count == 4 {
                if self.timeLeft == 0 && self.toggleNotification && self.showNotificationAtTimersEnd {
                    let content = UNMutableNotificationContent()
                    content.title = "Timer Ended"
                    content.subtitle = "Timer Ender"
                    content.sound = UNNotificationSound.default

                    // show this notification five seconds from now
                    let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)

                    // choose a random identifier
                    let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)

                    // add our notification request
                    UNUserNotificationCenter.current().add(request)
                    self.toggleNotification = false
                    print("Notification Fired")
                }
                
                
            }
            
        
           // print(self.Count)
        }
    }
    
    
    @objc func test() {
        
        
        var hours = 0
        var minutes = 0
        var seconds = 0
        
        var hoursString = "00"
        var minutesString = "00"
        var secondsString = "00"
        //Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true) { timer in
            if self.timeLeft > 0.0 {
                print("\(self.timeLeft)")
                
                hours = Int(self.timeLeft / 3600)
                minutes = Int((Int(self.timeLeft) - (hours * 3600)) / 60)
                seconds = Int((Double(self.timeLeft) - Double(hours * 3600) - Double(minutes * 60)))
                self.timeLeft -= 1
                
                
                
            }
            else {
                self.timeLeft = 0
                self.toggleNotification = true
                
                self.Count = 4
                
                
            }
        
        
            if hours < 10 {
                hoursString = String("0\(hours)")
            } else { hoursString = String("\(hours)")}
        
            if minutes < 10 {
                minutesString = String("0\(minutes)")
            } else { minutesString = String("\(minutes)")}
        
            if seconds < 10 {
                secondsString = String("0\(seconds)")
            } else { secondsString = String("\(seconds)")}
            /// Allows for a nice time format date where each component is always two characters
        

            //self.statusBarItem?.button?.title = String(format: "%.2f",self.timeLeft)
        
            statusBarItem?.button?.image = NSImage(systemSymbolName: "timer", accessibilityDescription: nil)
            self.statusBarItem?.button?.title = String("\(hoursString):\(minutesString):\(secondsString)")
       // }
            
        

    }
    
    
    @objc func timetillprojectcompletion() {
        var time = Date().timeIntervalSince(UserPreference().dueDate)
        time =  -(time / 3600)
        self.statusBarItem?.button?.image = NSImage(systemSymbolName: "wand.and.stars", accessibilityDescription: nil)
        
        if time <= 0 {
            self.statusBarItem?.button?.title = String(0) + " h"
            self.toggleNotification = true
            self.eventDone = true
            self.Count = 4
        } else {
            self.statusBarItem?.button?.title = String(format:eventres,time) + " h"
        }
    }
    
    @objc func timediff(){
                let time = Date().timeIntervalSince(UserPreference().birthdate)
                let yearsold = Double(time) / 31557600
                //print(time)
               // return Double(time)
        
                    //self.statusBarItem?.button?.image = NSImage(named: "birthdayCandleLight")?.resized(to: NSSize(width: 23, height: 23))
        self.statusBarItem?.button?.image = NSImage(systemSymbolName: "lightbulb", accessibilityDescription: nil) //had to use an SF symbol due to the fact that could not figure out how to get the color of the text on the menu bar.
        
            
        
                self.statusBarItem?.button?.title = String(format:birthdayres,yearsold)
            
            

    }
    
    

    func applicationDidFinishLaunching(_ notification: Notification) {
        
        let contentView = ContentView()
        
        
        // Set the SwiftUI's ContentView to the Popover's ContentViewController
        popover.behavior = .transient
        popover.animates = false
        popover.contentViewController = NSViewController()
        popover.contentViewController?.view = NSHostingView(rootView: contentView)
        popover.contentViewController?.view.window?.makeKey()
        
        
        
        
        
    
        statusBarItem = NSStatusBar.system.statusItem(withLength: NSStatusItem.variableLength)
        statusBarItem?.button?.image = NSImage(systemSymbolName: "square.and.arrow.up.fill", accessibilityDescription: nil)
        statusBarItem?.button?.imagePosition = NSControl.ImagePosition.imageLeft
        statusBarItem?.button?.title = "Not Yet Started"
        statusBarItem?.button?.action = #selector(AppDelegate.togglePopover(_:))
        
        if self.isFirstLaunch { showLoginAlert() }
        
        
        
        
        setCount()
    }
     
    
//    @objc func showAboutpanel() {
//        NSApp.activate(ignoringOtherApps: true)
//        NSApp.orderFrontStandardAboutPanel()
//
//        window = NSWindow(
//            contentRect: NSRect(x: 0, y: 0, width: 480, height: 300),
//            styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
//            backing: .buffered, defer: false)
//
//
//
//
//        window?.makeKeyAndOrderFront(nil)
//
//        window?.close()
//
//
//
//    }
    
    
    @objc func showLoginAlert() { // Documentation To come7
        
        
        if isFirstLaunch {
            
            
            window =  NSWindow(
                contentRect: NSRect(x: 0, y: 0, width: 10, height: 10),
                styleMask: [.titled, .closable, .miniaturizable, .resizable, .fullSizeContentView],
                backing: .buffered, defer: true)
            
           
            window?.tabbingMode = .disallowed
            window?.isOpaque = false
            window?.backgroundColor = .clear
            window?.maxSize =  CGSize(width: 10, height: 10)
            window?.center()
            window?.showsResizeIndicator = false
            window?.makeKeyAndOrderFront(nil)
            
            NSApp.activate(ignoringOtherApps: true)
            
            let dialogMessage = NSAlert()
//                dialogMessage.alertStyle = .informational
                dialogMessage.messageText = "Thank you for install TimeLeftUntil"
                dialogMessage.informativeText =  """
                This app is designed to do 3 things, (well maybe more but not intenotially),1. remind you that you are getting older so you are being more productive and doing more of your time here with us on earth, 2. Let you know how much time you have left until an event is/ a project is due/ or even when should you go outside your house. 3. The most boring features of this app but I mean it works well, the countdown, lets say you... well I really shouldn't explain this to you.

                    Who is the developer is this amazing app. Well its Noe de La Croix. @TheFrenchGuyFr on Twitter. I am 18 years old and I guess I am just starting my computer science carrer. About to go uni and decided to do a short week project to code during the 2021 summer. If you find anything wrong with the app or you want an extra features feel free to contact me, could always use some advice.


                    A bit more about the app, designed using xCode 13 and using swiftUI for all of the main views except maybe a few, the source code is available on github, feel once again free to have a look there. By using the app I assume that you have agreed with the terms and conditions (available under the settings tap and then click on the icon)
                """
            
            
            dialogMessage.addButton(withTitle: "Okay I'll start using the app")
            
         //   dialogMessage.buttons[0].target = self
         //   dialogMessage.buttons[0].action =  #selector(AppDelegate.toggleFirstLaunchAlert(_:))
                
            dialogMessage.buttons[0].hasDestructiveAction = true
        
            dialogMessage.accessoryView = NSView(frame: NSMakeRect(0, 0, 500, 0))
            
            dialogMessage.beginSheetModal(for: window!, completionHandler: { (modalResponse) -> Void in
                if modalResponse == NSApplication.ModalResponse.alertFirstButtonReturn {
                    self.toggleFirstLaunchAlert()
                    self.window?.close()
                }
            })
            //dialogMessage.runModal()
            
            
           // window?.close()
            
            
            print("alert presented")
           
            
        } else {
            print("Not the first launch")
        }
        
        
        
    }
    @objc func showPopover(_ sender: AnyObject?) {
        if let button = statusBarItem?.button {
            popover.show(relativeTo: button.bounds, of: button, preferredEdge: NSRectEdge.minY)
//            !!! - displays the popover window with an offset in x in macOS BigSur.
        }
    }
    @objc func closePopover(_ sender: AnyObject?) {
        popover.performClose(sender)
    }
    @objc func togglePopover(_ sender: AnyObject?) {
        if popover.isShown {
            closePopover(sender)
        } else {
            showPopover(sender)
        }
    }
    
    
    
    @objc func toggleFirstLaunchAlert() {
        isFirstLaunch = false
        print("checkedv")
    }
    
    
    
    
    
    
}

