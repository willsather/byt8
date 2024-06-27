//
//  Functions.swift
//  Bytes
//
//  Created by Will Sather on 6/14/21.
//

import Foundation
import Firebase
import HealthKit

public func registerForPushNotifications() {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate

    // 1
    UNUserNotificationCenter.current().delegate = appDelegate
    // 2
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(options: authOptions) { _, _ in }
    
    // 3
    UIApplication.shared.registerForRemoteNotifications()
    
    Messaging.messaging().delegate = appDelegate
                    
    db = Database.database().reference()

    // Write new FCM Token to Database
    Auth.auth().signInAnonymously() { (authResult, error) in
        
        if (error == nil) {
            
            guard let user = authResult?.user else { return }
            let uid = user.uid
            
            Messaging.messaging().token { token, error in
              if let error = error {
                print("Error fetching FCM token: \(error)")
              } else if let token = token {
                // Write Data to Realtime Database
                db.child("root").child("users").child(uid).child("fcm").child("token").setValue(token)
              }
            }
        }
        else {
            print("Authentication error")
        }
        
    } // End Auth
    
    print("Done Registering Notifications")
}

public func getDateAsString() -> String {
    // Calculate today's date
    let df = DateFormatter()
    df.dateFormat = "yyyy-MM-dd"
    
    return df.string(from: Date())
}

public func calcProgress(param1: Double, param2: Double) -> Double {
    return param1 / (param1 + param2)
}

public func calcProgressTotal(param1: Double, total: Double) -> Double {
    return param1 / total
}

public func calcAverageTemperature(arr: [Double]) -> Double {
   
    if (arr.count == 0) {
        return 0.0
    }
    
    var sum = 0.0
    for temp in arr {
        sum = sum + temp
    }
    
    return sum / Double(arr.count)
}

public func calcAverageSteps(arr: [Int]) -> Int {
   
    if (arr.count == 0) {
        return 0
    }
    
    var sum = 0
    for steps in arr {
        sum = sum + steps
    }
    
    return sum / arr.count
}

