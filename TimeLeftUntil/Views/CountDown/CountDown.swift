//
//  CountDown.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 06/07/2021.
//

import SwiftUI
import Combine


struct CountDown: View {
    
    @ObservedObject var userPreference = UserPreference()
    
    
    @State var hours = 0
    @State var hoursString = ""
    @State var minutes = 0
    @State var minutesString = ""
    @State var seconds = 0
    @State var secondsString = ""
    
    
    @State private var selected: Bool = false
    
    
    var body: some View {
        
        ZStack {
        if !selected {
        
        VStack {
            
            HStack {
                
                Text("CountDown: ")
                HStack{
                    
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("hh", text: self.$hoursString)
                                .frame(width: 30, height: 30)
                                .onReceive(Just(self.hoursString)) {newValue in
                                    let filtered  = newValue.filter { "0123456789".contains($0) }
                                    if filtered != newValue {
                                        
//                                        self.hoursString = filtered
//                                        self.hours =  0
                                        
                                        
                                        
                                    } else {
                                        self.hours = Int(filtered) ?? 0
                                    }
                                    
                                    
                                    
                                }
                            
                            Stepper("hours", onIncrement: {
                                hours += 1
                                self.hoursString = String(self.hours)
                            }, onDecrement: {
                                
                                if hours <= 0 {
                                    hours = 0
                                    self.hoursString = ""
                                } else {
                                    hours -= 1
                                    self.hoursString = String(self.hours)
                                }
                            })
                                .labelsHidden()
                            
                            Text(":")
                        }
                        Text("Hours")
                        
                    }
                    
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("mm", text: self.$minutesString)
                                .frame(width: 30, height: 30)
                                .onReceive(Just(self.minutesString)) {newValue in
                                    let filtered  = newValue.filter { $0.isNumber }
                                    if filtered != newValue {
                                            self.minutesString = filtered
                                            self.minutes = 0
                                        
                                    } else {
                                        if (Int(filtered) ?? -1) >= 60 {
                                            self.hoursString = String(self.hours + 1)
                                            self.hours += 1
                                            
                                            self.minutesString = "0"
                                            self.minutes = 0
                                            
                                          //  self.userPreference.countDownMinutes = Int(filtered) ?? 0
                                            
                                            print("Over 60 minutes")
                                        }
                                        
                                        else {
                                            self.minutes = Int(filtered) ?? 0
                                            
                                          //  self.userPreference.countDownMinutes = Int(filtered) ?? 0
                                        }
                                    }
                                    
                                }
                            
                            Stepper("minutes", onIncrement: {
                                minutes += 1
                                self.minutesString = String(self.minutes)
                            }, onDecrement: {
                                
                                if minutes <= 0 {
                                    minutes = 0
                                    self.minutesString = ""
                                } else {
                                    minutes -= 1
                                    self.minutesString = String(self.minutes)
                                }
                            })
                            
                                .labelsHidden()
                            
                            
                            Text(":")
                        }
                        Text("Minutes")
                    }
                    
                   
                    
                    VStack(alignment: .leading) {
                        HStack {
                            TextField("ss", text: self.$secondsString)
                                .frame(width: 30, height: 30)
                                .onReceive(Just(self.secondsString)) {newValue in
                                    let filtered  = newValue.filter { $0.isNumber }
                                    if filtered != newValue {
                                        self.secondsString = filtered
                                        self.seconds = 0
                                    } else {
                                        
                                        if (Int(filtered) ?? -1) >= 60 {
                                            self.minutesString = String(self.minutes + 1)
                                            self.minutes += 1
                                            
                                            self.secondsString = "0"
                                            self.seconds = 0
                                            
                                            
                                            
                                     //       self.userPreference.countDownSeconds = Int(filtered) ?? 0
                                            
                                            print("Over 60 seconds")
                                        } else {
                                            self.seconds = Int(filtered) ?? 0
                                            
                                      //      self.userPreference.countDownSeconds = Int(filtered) ?? 0
                                        }
                                        
                                    }
                                    
                                }
    
                            Stepper("seconds", onIncrement: {
                                seconds += 1
                                self.secondsString = String(self.seconds)
                            }, onDecrement: {
                                
                                if seconds <= 0 {
                                    seconds = 0
                                    self.secondsString = ""
                                } else {
                                    seconds -= 1
                                    self.secondsString = String(self.seconds)
                                }
                            })
                            
                                .labelsHidden()
                        }
                        Text("Seconds")
                    }
                    
                }.padding()
                 .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.black.opacity(0.1)))
            }
            
            Button(action: {
                userPreference.testtimer = Double((self.hours * 3600) + (self.minutes * 60) + (self.seconds))
                print("userPrefrence timer is \(userPreference.testtimer)")
                print("Hours \(hours)")
                print("Minutes \(minutes)")
                print("Seconds \(seconds)")
                
                
                StoreVar()
                
                
                selected.toggle()
                
                userPreference.setChoice = 3
                
                NotificationCenter.default.post(name: NSNotification.Name(rawValue: "countCount") , object: nil)
                
            }) {
                Text("Start")
            }.onChange(of: userPreference.testtimer) {newValue in
                UserDefaults.standard.set(userPreference.testtimer, forKey: "testtimer") // This means that the user is logging in the first time so he must complete the daily intake calculator
                NotificationCenter.default.post(name: NSNotification.Name("testtimer"), object: nil) //Put a backend notification to inform app the data has been written
                
                
                UserDefaults.standard.set(3, forKey: "setChoice") // This means that the user is logging in the first time so he must complete the daily intake calculator
                NotificationCenter.default.post(name: NSNotification.Name("setChoice"), object: nil) //Put a backend notification to inform app the data has been written
            }
        }.frame(height: 130)
            
        
        
            .onAppear(perform: {
                hoursString = String(userPreference.countDownHours)
                minutesString = String(userPreference.countDownMinutes)
                secondsString = String(userPreference.countDownSeconds)
                print("assigned Variables")
            })
            
        } else {
            ConfirmationView(selected: self.$selected, TextCustom: "Well its a basic timer what can I tell you", LottieViewName: "timerAnimation", notificationTitle: "Well the countdown has started", notificationSub: "what do you want me else to say -work")
        }
            
        }
    }
                      
                      
    private func StoreVar() {
                userPreference.countDownHours = hours
                userPreference.countDownMinutes = minutes
                userPreference.countDownSeconds = seconds
                UserDefaults.standard.synchronize()
                print("Saved succefully")
            }
}

struct CountDown_Previews: PreviewProvider {
    static var previews: some View {
        CountDown()
    }
}


