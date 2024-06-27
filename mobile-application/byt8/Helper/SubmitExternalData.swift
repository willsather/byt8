//
//  PullExternalData.swift
//  byt8
//
//  Created by Will Sather on 6/20/21.
//

import Foundation
import HealthKit
import CoreLocation
import Firebase

/*
 External Data functions
 */

public func submitExternalData() {
        
    // Write Answer to firebase
    db = Database.database().reference()
    
    Auth.auth().signInAnonymously() { (authResult, error) in
        
        if (error == nil) {
            
            guard let user = authResult?.user else { return }
            let uid = user.uid
            
            // Write Data to Realtime Database
            db.child("root").child("users").child(uid).child("data").child(getDateAsString()).child("day_of_week").setValue(getDayOfWeek())
            
            getTodaysSteps() {(steps) in
                db.child("root").child("users").child(uid).child("data").child(getDateAsString()).child("daily_steps").setValue(Int(steps))
            }
            
            getAverageTemperature() {(temp) in
                db.child("root").child("users").child(uid).child("data").child(getDateAsString()).child("avg_temp").setValue(temp)
            }
        }
        else {
            print("Authentication error")
        }
    }
}

/*
 Get Day of Week
 */
func getDayOfWeek() -> String {
    
    let weekDays = [
        "Sunday",
        "Monday",
        "Tuesday",
        "Wednesday",
        "Thursday",
        "Friday",
        "Saturday"
    ]
        
    return weekDays[Calendar(identifier: .gregorian).component(.weekday, from: Date())-1]
}

/*
 Get Total Steps for Day
 */
func getTodaysSteps(completion: @escaping (Double) -> Void) {
    
    let healthStore = HKHealthStore()
    
    let stepsQuantityType = HKQuantityType.quantityType(forIdentifier: .stepCount)!
    
    let now = Date()
    let startOfDay = Calendar.current.startOfDay(for: now)
    let predicate = HKQuery.predicateForSamples(
        withStart: startOfDay,
        end: now,
        options: .strictStartDate
    )
    
    let query = HKStatisticsQuery(
        quantityType: stepsQuantityType,
        quantitySamplePredicate: predicate,
        options: .cumulativeSum
    ) { _, result, _ in
        guard let result = result, let sum = result.sumQuantity() else {
            completion(0.0)
            return
        }
        print("Steps: \(sum.doubleValue(for: HKUnit.count()))")
        completion(sum.doubleValue(for: HKUnit.count()))
    }
    
    healthStore.execute(query)
}

/*
 Get Average Temperature for Day
 */
func getAverageTemperature(completion: @escaping (_ temp: Double?) -> Void) {
    
    let latitude = UserDefaults.standard.integer(forKey: "latitude")
    let longitude = UserDefaults.standard.integer(forKey: "longitude")
    
    print("Latitude: \(latitude)")
    print("Longitude: \(longitude)")

    let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&exclude=current,minutely,hourly,alerts&appid=eabf626b9ac74bd7cb9a843c49ab4e4f&units=imperial")

    pullJSONData(url: url) { (completed) in
        print("Average Temperature: \(completed)")
        completion(completed)
    }
}

/*
 Helper Structs to Parse JSON
 */
struct WeatherModel: Decodable {
    var main: Temperature?
}

struct Temperature: Decodable {
    var temp: Double?
    var feels_like: Double?
    var temp_min: Double?
    var temp_max: Double?
    var pressure: Int?
    var humidity: Int?
    var sea_level: Int?
    var grnd_level: Int?
}

/*
 Pull Weather Data from JSON
 */
func pullJSONData(url: URL?, completed: @escaping (_ temp: Double?) -> Void) {
    
    let task = URLSession.shared.dataTask(with: url!) { data, response, error in
        if let error = error {
            print("Error : \(error.localizedDescription)")
        }
        
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            print("Error : HTTP Response Code Error")
            return
        }
        
        guard let data = data else {
            print("Error : No Response")
            return
        }
        
        let weatherData = try? JSONDecoder().decode(WeatherModel.self, from: data)
    
        completed(weatherData?.main?.temp_max)
        
    }.resume()

}

