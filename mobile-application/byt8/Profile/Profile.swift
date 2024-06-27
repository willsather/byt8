//
//  Profile.swift
//  Bytes
//
//  Created by Will Sather on 6/15/21.
//

import Foundation

class Profile: ObservableObject {
    
    var first_name : String
    var last_name : String
    var birthday : Date = Date()
    var notifications : Bool = UserDefaults.standard.bool(forKey: "notifications")
    
    init() {
        self.first_name = ""
        self.last_name = ""
        getProfile()
    }
    
    init(first: String, last: String, birthday: Date) {
        self.first_name = first
        self.last_name = last
        self.birthday = birthday
        self.notifications = UserDefaults.standard.bool(forKey: "notifications")
    }
    
    func getProfile() {
                
        self.first_name = UserDefaults.standard.string(forKey: "first_name") ?? ""
        self.last_name = UserDefaults.standard.string(forKey: "last_name") ?? ""

        self.notifications = UserDefaults.standard.bool(forKey: "notifications")
        
        // Get Birthday
        let bdayStr = UserDefaults.standard.string(forKey: "birthday") ?? ""
        let df = DateFormatter()
        
        df.dateFormat = "dd/MM/yyyy HH:mm"
        
        var date = Date()
        
        if (bdayStr != "") {
            date = df.date(from: bdayStr) ?? Date()
        }
        
        self.birthday = date
    }
    
    func saveProfile() {
         
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MM-dd-YYYY"
        
        // Write Data
        UserDefaults.standard.set(self.first_name, forKey: "first_name")
        UserDefaults.standard.set(self.last_name, forKey: "last_name")
        
        // Write Birthday
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy HH:mm"
        let bdayStr = df.string(from: self.birthday)
        
        UserDefaults.standard.set(bdayStr, forKey: "birthday")
    }
    
    func saveProfile(stateFirstName:String, stateLastName: String, stateBirthday: Date) {
        self.first_name = stateFirstName
        self.last_name = stateLastName
        self.birthday = stateBirthday

        self.saveProfile()
    }
}
