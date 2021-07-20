//
//  ProjectDueDate.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 06/07/2021.
//

import SwiftUI
import SDWebImageLottieCoder
import SDWebImage

struct ProjectDueDate: View {
    
    @State var project_due_date = Date()
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var userPreference = UserPreference()
    
    @State private var selected: Bool = false
    
    @State var showPopupAlert: Bool = false
    
    
    var body: some View {
        
        ZStack {
            if !selected {
            
                VStack(alignment: .center) {
                    
                    Text("So when is that project due? 📚").font(.title)
                    DatePicker("Project Due Date", selection: $userPreference.dueDate,displayedComponents: [.date, .hourAndMinute]).onChange(of: userPreference.dueDate, perform: { value in
                            if userPreference.dueDate.timeIntervalSince(Date()) < -1 {
                                print("less than a second difference since last time")
                                userPreference.dueDate = Date().addingTimeInterval(60)
                                showPopupAlert.toggle() // so will display when the user tries to set a due date in the past
                                
                            }
                    })
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .labelsHidden()
                        .frame(width: 240)
                        .padding()
                    .alert(isPresented: self.$showPopupAlert, content: {
                        Alert(title: Text("Well if your trying to set a due date in the past you are late"))
                    })
                        
                    
                    VStack {
                        Text("So you will be 'done' with that project on")
                        Text("\(userPreference.dueDate, style: .date) at \(userPreference.dueDate, style: .time)")
                    }.padding()
                        .background(RoundedRectangle(cornerRadius: 12).foregroundColor(.black.opacity(0.1)))
                    
                    
                    Button(action: {
                        selected.toggle()
                        
                        userPreference.setChoice = 2
                        
                        UserDefaults.standard.set(2, forKey: "setChoice")
                        NotificationCenter.default.post(name: NSNotification.Name("setChoice"), object: nil)
                    }) {
                        Text("Get Started ✅")
                    }
                }
                .frame(width: 360)
                
            } else {
                
                
                ConfirmationView(selected: self.$selected, TextCustom: "So you will know when to stress", LottieViewName: "calendarAnimation", notificationTitle: "The hours are getting away", notificationSub: "Don't worry you will be fine just 'work' ")
                
                
                
            }
            
            
        }
    }
}

struct ProjectDueDate_Previews: PreviewProvider {
    static var previews: some View {
        ProjectDueDate()
    }
}



