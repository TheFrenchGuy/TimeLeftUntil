//
//  ContentView.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 05/07/2021.
//

import SwiftUI
import AppKit
import Combine
import UserNotifications
import Lottie


struct ContentView: View {
    @ObservedObject var userPreference = UserPreference()
    @Environment(\.colorScheme) var colorScheme
    
    
    @State var selectedTab = 0

    var body: some View {
        VStack(alignment: .center, spacing: 0) {
                VStack {
                
    //                Stepper("Stepper value: \(userPreference.testtimer)", value: $userPreference.testtimer).onChange(of: userPreference.testtimer) { newValue in
    //                    UserDefaults.standard.set(userPreference.testtimer, forKey: "testtimer") // This means that the user is logging in the first time so he must complete the daily intake calculator
    //                    NotificationCenter.default.post(name: NSNotification.Name("testtimer"), object: nil) //Put a backend notific ation to inform app the data has been written
    //                }
//                    TabView {
//
//                        GettingOlderView().tabItem{
//                            Text("Birth 🎂")
//                        }
//
//                        ProjectDueDate().tabItem {
//                            Text("Project 💷")
//                        }
//
//
//                        CountDown().tabItem {
//                            Text("Timer ⏲")
//                        }
//
//                        SettingsView().tabItem {
//                            Text("􀈁")
//
//                        }
//                    }
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut) {
                                selectedTab = 0
                            }
                        }) {
                            Text("Birth 🎂").foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        }.buttonStyle(.borderless)
                            .padding(5)
                            .background(selectedTab == 0 ? RoundedRectangle(cornerRadius: 12).foregroundColor(Color.blue) : RoundedRectangle(cornerRadius: 12).foregroundColor(.clear) )
                        
                        Divider()
                        Button(action: {
                            withAnimation() {
                                selectedTab = 1
                            }
                            
                        }) {
                            Text("Project 💷").foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        }.buttonStyle(.borderless)
                            .padding(5)
                            .background(selectedTab == 1 ? RoundedRectangle(cornerRadius: 12).foregroundColor(Color.blue) : RoundedRectangle(cornerRadius: 12).foregroundColor(.clear) )
                        
                        Divider()
                        
                        Button(action: {
                            withAnimation() {
                                selectedTab = 2
                            }
                        }) {
                            Text("Timer ⏲").foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        }.buttonStyle(.borderless)
                            .padding(5)
                            .background(selectedTab == 2 ? RoundedRectangle(cornerRadius: 12).foregroundColor(Color.blue) : RoundedRectangle(cornerRadius: 12).foregroundColor(.clear) )
                        
                        Divider()
                        
                        Button(action: {
                            
                            withAnimation() {
                                selectedTab = 3
                            }
                            
                        }) {
                            Text("􀈁").foregroundColor(colorScheme == .light ? Color.black : Color.white)
                        }.buttonStyle(.borderless)
                            .padding(5)
                            .background(selectedTab == 3 ? RoundedRectangle(cornerRadius: 12).foregroundColor(Color.blue) : RoundedRectangle(cornerRadius: 12).foregroundColor(.clear) )
                        
                        
                    }.frame(height: 33)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(colorScheme == .light ? Color.white : Color.black.opacity(0.3)))
                    
                    
                    switch (selectedTab) {
                        case 0:
                            GettingOlderView()
                        case 1:
                            ProjectDueDate()
                        case 2:
                            CountDown()
                        case 3:
                            SettingsView()
                        
                        default:
                            EmptyView()
                        
                    }
                    
                    
                        
                        
                        
                } .onAppear(perform: {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                            if success {
                                print("Notification Access allowed")
                            } else if let error = error {
                                print(error.localizedDescription)
                            }
                        }
                    }
                    
                })
                    
            
                
                .padding(.top, 5)
            .frame(width: 360.0, alignment: .top)
            
            
            
        }
        .padding(0)
        .frame(width: 360.0, height: 380.0, alignment: .top)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

