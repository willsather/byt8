//
//  File.swift
//  byt8
//
//  Created by Will Sather on 7/3/21.
//

import Foundation
import Firebase

class SpecificData: ObservableObject {
    
    @Published var healthyPercent: Double = 0.0
    @Published var productivePercent: Double = 0.0
    @Published var readingPercent: Double = 0.0
    @Published var learningPercent: Double = 0.0
    @Published var workoutPercent: Double = 0.0
    @Published var newPeoplePercent: Double = 0.0
    @Published var drinkingPercent: Double = 0.0
    
    @Published var goodPercent: Double = 0.0
    
    @Published var statsInfo: StatsInfo = StatsInfo()
    
    init(type: String) {
        getSpecificData(dayType: type)
    }
    
    func getSpecificData(dayType: String) {
        
        self.resetData()
        
        if (!self.statsInfo.dataLoaded) {
            
            Auth.auth().signInAnonymously() { (authResult, error) in
                
                if (error == nil) {
                    
                    guard let user = authResult?.user else { return }
                    let uid = user.uid
                                                            
                    // Write Data to Realtime Database
                    db = Database.database().reference()
                    
                    db.child("root").child("users").child(uid).child("data").observe(.value, with: { (snapshot) in
                        
                        self.resetData()
                                                
                        for child in snapshot.children.allObjects as! [DataSnapshot] {
                                                                                                                                            
                            // Good Bad Days
                            if (child.childSnapshot(forPath: "good_bad").value as? String == dayType) {
                                
                                self.statsInfo.totalDays += 1
                                
                                // Reading Days
                                if (child.childSnapshot(forPath: "read").value as? String == "Yes") {
                                    self.statsInfo.readDays += 1
                                } else if (child.childSnapshot(forPath: "read").value as? String == "No") {
                                    self.statsInfo.noReadDays += 1
                                }
                                
                                // Productive Days
                                if (child.childSnapshot(forPath: "productive").value as? String == "Yes") {
                                    self.statsInfo.productiveDays += 1
                                } else if (child.childSnapshot(forPath: "productive").value as? String == "No") {
                                    self.statsInfo.noProductiveDays += 1
                                }
                                                            
                                // Healthy Days
                                if (child.childSnapshot(forPath: "healthy").value as? String == "Healthy") {
                                    self.statsInfo.healthyDays += 1
                                } else if (child.childSnapshot(forPath: "healthy").value as? String == "Unhealthy") {
                                    self.statsInfo.noHealthyDays += 1
                                }
                                
                                // Learning Days
                                if (child.childSnapshot(forPath: "learning").value as? String == "Yes") {
                                    self.statsInfo.learningDays += 1
                                } else if (child.childSnapshot(forPath: "learning").value as? String == "No") {
                                    self.statsInfo.noLearningDays += 1
                                }
                                
                                // Workout Days
                                if (child.childSnapshot(forPath: "workout").value as? String == "Yes") {
                                    self.statsInfo.workoutDays += 1
                                } else if (child.childSnapshot(forPath: "workout").value as? String == "No") {
                                    self.statsInfo.noWorkoutDays += 1
                                }
                                
                                // New Person Days
                                if (child.childSnapshot(forPath: "new_person").value as? String == "Yes") {
                                    self.statsInfo.newPersondays += 1
                                } else if (child.childSnapshot(forPath: "new_person").value as? String == "No") {
                                    self.statsInfo.noNewPersondays += 1
                                }
                                
                                // Drinking Days
                                if (child.childSnapshot(forPath: "party").value as? String == "Yes") {
                                    self.statsInfo.partyDays += 1
                                } else if (child.childSnapshot(forPath: "party").value as? String == "No") {
                                    self.statsInfo.noPartyDays += 1
                                }
                                /*
                                
                                // Steps
                                var steps = child.childSnapshot(forPath: "daily_steps").value as? Int
                                
                                // If Steps was stored as Float in DB
                                if (steps == nil) {
                                    let steps_double = child.childSnapshot(forPath: "daily_steps").value as? Double
                                    if (steps_double != nil) {
                                        steps = Int(steps_double!)
                                    }
                                }

                                if (steps != 0 && steps != nil) {
                                    self.statsInfo.steps.append(steps!)
                                }
                                
                                // Temperature
                                let temp = child.childSnapshot(forPath: "avg_temp").value as? Double
                                if (temp != 0.0 && temp != nil) {
                                    self.statsInfo.temperatures.append(temp!)
                                }
                                */
                                
                            }
                            /*
                            print("==============================")
                            print("DAY TYPE: \(dayType)")
                            print("healthyDays: \(self.statsInfo.healthyDays)")
                            print("productiveDays: \(self.statsInfo.productiveDays)")
                            print("readingDays: \(self.statsInfo.readDays)")
                            print("learningDays: \(self.statsInfo.learningDays)")
                            print("workoutDays: \(self.statsInfo.workoutDays)")
                            print("newPeopleDays: \(self.statsInfo.newPersondays)")
                            print("drinkingDays: \(self.statsInfo.partyDays)")
                            print("totalDays: \(self.statsInfo.totalDays)")
                            */
                            
                            if (self.statsInfo.totalDays > 0) {
                                
                                self.healthyPercent = Double(self.statsInfo.healthyDays) / Double(self.statsInfo.totalDays)
                                self.productivePercent = Double(self.statsInfo.productiveDays) / Double(self.statsInfo.totalDays)
                                self.readingPercent = Double(self.statsInfo.readDays) / Double(self.statsInfo.totalDays)
                                self.learningPercent = Double(self.statsInfo.learningDays) / Double(self.statsInfo.totalDays)
                                self.workoutPercent = Double(self.statsInfo.workoutDays) / Double(self.statsInfo.totalDays)
                                self.newPeoplePercent = Double(self.statsInfo.newPersondays) / Double(self.statsInfo.totalDays)
                                self.drinkingPercent = Double(self.statsInfo.partyDays) / Double(self.statsInfo.totalDays)
                                
                            }
                            /*
                            print("healthy % : \(self.healthyPercent)")
                            print("productive %: \(self.productivePercent)")
                            print("reading %: \(self.readingPercent)")
                            print("learning %: \(self.learningPercent)")
                            print("workout %: \(self.workoutPercent)")
                            print("newPeople %: \(self.newPeoplePercent)")
                            print("drinking %: \(self.drinkingPercent)")
                            
                            
                            print("==============================")
                            */
                            self.statsInfo.dataLoaded = true
                        }
                    })
                   
                } else {
                    print("Authentication error")
                }
            }
        }
        
    }
    
    func getSpecificDay(type: String) -> Int {
        
        if (type == "Good") {
            return self.statsInfo.goodDays
        }
        
        else if (type == "Ok") {
            return self.statsInfo.okDays
        }
        
        else {
            return self.statsInfo.badDays
        }
    }
    
    func resetData() {
        
        self.statsInfo.resetDataVariables()
        
        self.healthyPercent = 0.0
        self.productivePercent = 0.0
        self.readingPercent = 0.0
        self.learningPercent = 0.0
        self.workoutPercent = 0.0
        self.newPeoplePercent = 0.0
        self.drinkingPercent = 0.0
        
        self.statsInfo.dataLoaded = false
    }
} // Class
