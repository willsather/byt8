//
//  StatsInfo.swift
//  Bytes
//
//  Created by Will Sather on 6/15/21.
//

import SwiftUI
import Foundation
import Firebase

class StatsInfo: ObservableObject {
    
    @Published var dataLoaded: Bool = false
    @Published var totalDays: Int = 0
    
    @Published var goodDays: Int = 0
    @Published var okDays: Int = 0
    @Published var badDays: Int = 0
    
    @Published var readDays: Int = 0
    @Published var noReadDays: Int = 0
    
    @Published var productiveDays: Int = 0
    @Published var noProductiveDays: Int = 0
    
    @Published var healthyDays: Int = 0
    @Published var noHealthyDays: Int = 0
    
    @Published var learningDays: Int = 0
    @Published var noLearningDays: Int = 0
    
    @Published var workoutDays: Int = 0
    @Published var noWorkoutDays: Int = 0
    
    @Published var newPersondays: Int = 0
    @Published var noNewPersondays: Int = 0
    
    @Published var partyDays: Int = 0
    @Published var noPartyDays: Int = 0
    
    @Published var temperatures: [Double] = []
    @Published var steps: [Int] = []
    
    @Published var dayOfWeekSunday: DayOfWeek = DayOfWeek(day: "Sunday")
    @Published var dayOfWeekMonday: DayOfWeek = DayOfWeek(day: "Monday")
    @Published var dayOfWeekTuesday: DayOfWeek = DayOfWeek(day: "Tuesday")
    @Published var dayOfWeekWednesday: DayOfWeek = DayOfWeek(day: "Wednesday")
    @Published var dayOfWeekThursday: DayOfWeek = DayOfWeek(day: "Thursday")
    @Published var dayOfWeekFriday: DayOfWeek = DayOfWeek(day: "Friday")
    @Published var dayOfWeekSaturday: DayOfWeek = DayOfWeek(day: "Saturday")

    func resetDataVariables() {
        
        totalDays = 0
        
        goodDays = 0
        okDays = 0
        badDays = 0
        
        readDays = 0
        noReadDays = 0
        
        productiveDays = 0
        noProductiveDays = 0
        
        healthyDays = 0
        noHealthyDays = 0
        
        learningDays = 0
        noLearningDays = 0
        
        workoutDays = 0
        noWorkoutDays = 0
        
        newPersondays = 0
        noNewPersondays = 0
        
        partyDays = 0
        noPartyDays = 0
        
        temperatures = []
        steps = []
        
        // Reset Each Day of Week Data
        dayOfWeekSunday.resetData()
        dayOfWeekMonday.resetData()
        dayOfWeekTuesday.resetData()
        dayOfWeekWednesday.resetData()
        dayOfWeekThursday.resetData()
        dayOfWeekFriday.resetData()
        dayOfWeekSaturday.resetData()

        self.dataLoaded = false
    }
    
    func getSpecificDay(type: String) -> Int {
        
        if (type == "Good") {
            return self.goodDays
        }
        
        else if (type == "Ok") {
            return self.okDays
        }
        
        else if (type == "Bad") {
            return self.badDays
        }
    
        return 0
    }
    
    func getSpecificSubject(subject: String) -> Int {
        
        if (subject == "Healthy") {
            return self.healthyDays
            
        } else if (subject == "Productive") {
            return self.productiveDays
            
        } else if (subject == "Reading") {
            return self.readDays
            
        } else if (subject == "Learning") {
            return self.learningDays
            
        } else if (subject == "Workout") {
            return self.workoutDays
            
        } else if (subject == "New People") {
            return self.newPersondays
            
        } else if (subject == "Drinking") {
            return self.partyDays
            
        }

        return 0
    }
    
    func getData() {
        
        self.resetDataVariables()
        
        if (!self.dataLoaded) {
            
            Auth.auth().signInAnonymously() { (authResult, error) in
                
                if (error == nil) {
                    
                    guard let user = authResult?.user else { return }
                    let uid = user.uid
                    
                    self.resetDataVariables()
                                        
                    // Write Data to Realtime Database
                    db = Database.database().reference()
                    
                    db.child("root").child("users").child(uid).child("data").observe(.value, with: { (snapshot) in
                                                
                        for child in snapshot.children.allObjects as! [DataSnapshot] {
                                                                                                                
                            // Good Bad Days
                            if (child.childSnapshot(forPath: "good_bad").value as? String == "Good") {
                                self.goodDays += 1
                                self.totalDays += 1
                                
                                if (child.childSnapshot(forPath: "day_of_week").value as? String == "Sunday") {
                                    self.dayOfWeekSunday.goodDays += 1
                                    
                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Monday") {
                                    self.dayOfWeekMonday.goodDays += 1
                                    
                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Tuesday") {
                                    self.dayOfWeekTuesday.goodDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Wednesday") {
                                    self.dayOfWeekWednesday.goodDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Thursday") {
                                    self.dayOfWeekThursday.goodDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Friday") {
                                    self.dayOfWeekFriday.goodDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Saturday") {
                                    self.dayOfWeekSaturday.goodDays += 1
                                }
                                
                            } else if (child.childSnapshot(forPath: "good_bad").value as? String == "Ok") {
                                self.okDays += 1
                                self.totalDays += 1
                                
                                if (child.childSnapshot(forPath: "day_of_week").value as? String == "Sunday") {
                                    self.dayOfWeekSunday.okDays += 1
                                    
                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Monday") {
                                    self.dayOfWeekMonday.okDays += 1
                                    
                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Tuesday") {
                                    self.dayOfWeekTuesday.okDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Wednesday") {
                                    self.dayOfWeekWednesday.okDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Thursday") {
                                    self.dayOfWeekThursday.okDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Friday") {
                                    self.dayOfWeekFriday.okDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Saturday") {
                                    self.dayOfWeekSaturday.okDays += 1
                                }
                                
                            } else if (child.childSnapshot(forPath: "good_bad").value as? String == "Bad") {
                                self.badDays += 1
                                self.totalDays += 1
                                
                                if (child.childSnapshot(forPath: "day_of_week").value as? String == "Sunday") {
                                    self.dayOfWeekSunday.badDays += 1
                                    
                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Monday") {
                                    self.dayOfWeekMonday.badDays += 1
                                    
                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Tuesday") {
                                    self.dayOfWeekTuesday.badDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Wednesday") {
                                    self.dayOfWeekWednesday.badDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Thursday") {
                                    self.dayOfWeekThursday.badDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Friday") {
                                    self.dayOfWeekFriday.badDays += 1

                                } else if (child.childSnapshot(forPath: "day_of_week").value as? String == "Saturday") {
                                    self.dayOfWeekSaturday.badDays += 1
                                }
                            }
                            
                            // Reading Days
                            if (child.childSnapshot(forPath: "read").value as? String == "Yes") {
                                self.readDays += 1
                            } else if (child.childSnapshot(forPath: "read").value as? String == "No") {
                                self.noReadDays += 1
                            }
                            
                            // Productive Days
                            if (child.childSnapshot(forPath: "productive").value as? String == "Yes") {
                                self.productiveDays += 1
                            } else if (child.childSnapshot(forPath: "productive").value as? String == "No") {
                                self.noProductiveDays += 1
                            }
                                                        
                            // Healthy Days
                            if (child.childSnapshot(forPath: "healthy").value as? String == "Healthy") {
                                self.healthyDays += 1
                            } else if (child.childSnapshot(forPath: "healthy").value as? String == "Unhealthy") {
                                self.noHealthyDays += 1
                            }
                            
                            // Learning Days
                            if (child.childSnapshot(forPath: "learning").value as? String == "Yes") {
                                self.learningDays += 1
                            } else if (child.childSnapshot(forPath: "learning").value as? String == "No") {
                                self.noLearningDays += 1
                            }
                            
                            // Workout Days
                            if (child.childSnapshot(forPath: "workout").value as? String == "Yes") {
                                self.workoutDays += 1
                            } else if (child.childSnapshot(forPath: "workout").value as? String == "No") {
                                self.noWorkoutDays += 1
                            }
                            
                            // New Person Days
                            if (child.childSnapshot(forPath: "new_person").value as? String == "Yes") {
                                self.newPersondays += 1
                            } else if (child.childSnapshot(forPath: "new_person").value as? String == "No") {
                                self.noNewPersondays += 1
                            }
                            
                            // Drinking Days
                            if (child.childSnapshot(forPath: "party").value as? String == "Yes") {
                                self.partyDays += 1
                            } else if (child.childSnapshot(forPath: "party").value as? String == "No") {
                                self.noPartyDays += 1
                            }
                            
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
                                self.steps.append(steps!)
                            }
                            
                            // Temperature
                            let temp = child.childSnapshot(forPath: "avg_temp").value as? Double
                            if (temp != 0.0 && temp != nil) {
                                self.temperatures.append(temp!)
                            }
                            
                        }
                        self.dataLoaded = true

                    })
                   
                } else {
                    print("Authentication error")
                }
            }
        }
    }
}

class DayOfWeek: ObservableObject {
    
    @Published var day: String
    @Published var goodDays: Int = 0
    @Published var okDays: Int = 0
    @Published var badDays: Int = 0
    
    init (day: String) {
        self.day = day
    }
    
    func getColor() -> Color {
        
        if (self.goodDays > 0 && self.goodDays > self.okDays && self.goodDays > self.badDays) {
            return Color.Fresh
            
            
        } else if (self.goodDays > 0 && self.goodDays == self.okDays) {
            return Color.Fresh.opacity(0.5)
            
        } else if (self.okDays > 0 && self.okDays > self.goodDays && self.okDays > self.badDays) {
            return Color.Sunshine
            
        } else if (self.okDays > 0 && self.okDays == self.badDays) {
            return Color.Sunshine.opacity(0.5)
            
        } else if (self.badDays > 0 && self.badDays >= self.goodDays && self.badDays >= self.badDays) {
            return Color.Vermillion
        }
         
        return Color.Clean
    }
    
    func resetData() {
        self.goodDays = 0
        self.okDays = 0
        self.badDays = 0
    }
}
