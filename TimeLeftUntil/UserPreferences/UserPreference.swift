//
//  UserPreference.swift
//  TimeLeftUntil
//
//  Created by Noe De La Croix on 05/07/2021.
//

import Foundation
import Combine

class UserPreference: ObservableObject, Equatable {
    static func == (lhs: UserPreference, rhs: UserPreference) -> Bool { //had to make it equatable to allow it to be checked when value is changed to see if the time difference is less than 0
        lhs.dueDate == rhs.dueDate
        
    }
    
    
    
    @Published var firstLaunch: Bool {
        didSet {
            UserDefaults.standard.set(firstLaunch, forKey: "firstLaunch")
        }
    }
    @Published var testtimer: Double {
        didSet {
            UserDefaults.standard.set(testtimer, forKey: "testtimer")
        }
    }
    
    @Published var countDownHours: Int {
        didSet {
            UserDefaults.standard.set(countDownHours, forKey: "countDownHours")
        }
    }
    
    @Published var countDownMinutes: Int {
        didSet {
            UserDefaults.standard.set(countDownMinutes, forKey: "countDownMinutes")
        }
    }
    
    @Published var countDownSeconds: Int {
        didSet {
            UserDefaults.standard.set(countDownSeconds, forKey: "countDownSeconds")
        }
    }
    
    
    @Published var birthdate: Date {
        didSet {
            UserDefaults.standard.set(birthdate, forKey: "birthdate")
        }
    }
    
    @Published var dueDate: Date {
        didSet {
            UserDefaults.standard.set(dueDate, forKey: "dueDate")
        }
    }
    
    @Published var setChoice: Int {
        didSet {
            UserDefaults.standard.set(setChoice, forKey: "setChoice")
        }
    }
    
    
    
    @Published var showNotifications: Bool {
        didSet {
            UserDefaults.standard.set(showNotifications, forKey: "showNotifications")
        }
    }
    @Published var setResolutionBirthday: String {
        didSet {
            UserDefaults.standard.set(setResolutionBirthday, forKey: "setResolutionBirthday")
        }
    }
    
    
    @Published var setEventCountDownResolution: String {
        didSet {
            UserDefaults.standard.set(setEventCountDownResolution, forKey: "setEventCountDownResolution")
        }
    }
    
    init() {
        
        self.firstLaunch = UserDefaults.standard.object(forKey: "firstLaunch") as? Bool ?? true
        
        self.testtimer = UserDefaults.standard.object(forKey: "testtimer") as? Double ?? 0.0
        
        self.countDownHours = UserDefaults.standard.object(forKey: "countDownHours") as? Int ?? 0
        self.countDownMinutes = UserDefaults.standard.object(forKey: "countDownMinutes") as? Int ?? 0
        self.countDownSeconds = UserDefaults.standard.object(forKey: "countDownSeconds") as? Int ?? 0
        self.birthdate = UserDefaults.standard.object(forKey: "birthdate") as? Date ?? Calendar.current.date(from: DateComponents( year: 2003, month: 4, day: 8))!
        
        self.dueDate = UserDefaults.standard.object(forKey: "dueDate") as? Date ?? Date()
        
        
        self.setChoice = UserDefaults.standard.object(forKey: "setChoice") as? Int ?? 0
        
        self.showNotifications = UserDefaults.standard.object(forKey: "showNotifications") as? Bool ?? true
        
        self.setResolutionBirthday = UserDefaults.standard.object(forKey: "setResolutionBirthday") as? String ?? "%.7f"
        
        self.setEventCountDownResolution = UserDefaults.standard.object(forKey: "setEventCountDownResolution") as? String ?? "%.5f"
        
    }
}
