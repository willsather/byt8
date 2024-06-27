//
//  SpecificDataSubject.swift
//  byt8
//
//  Created by Will Sather on 7/4/21.
//

import Foundation
import Firebase

class SpecificDataSubject: ObservableObject {
    
    @Published var goodPercent: Double = 0.0
    @Published var okPercent: Double = 0.0
    @Published var badPercent: Double = 0.0
    
    @Published var statsInfo: StatsInfo = StatsInfo()
    
    init(questionCode: String, answer: String) {
        getSpecificSubjectData(questionCode: questionCode, answer: answer)
    }
    
    func getSpecificSubjectData(questionCode: String, answer: String) {
        
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
                            if (child.childSnapshot(forPath: questionCode).value as? String == answer) {
                                
                                self.statsInfo.totalDays += 1
                                
                                // Reading Days
                                if (child.childSnapshot(forPath: "good_bad").value as? String == "Good") {
                                    self.statsInfo.goodDays += 1
                                } else if (child.childSnapshot(forPath: "good_bad").value as? String == "Ok") {
                                    self.statsInfo.okDays += 1
                                } else if (child.childSnapshot(forPath: "good_bad").value as? String == "Bad") {
                                    self.statsInfo.badDays += 1
                                }

                            }
                            
                            if (self.statsInfo.totalDays > 0) {
                                
                                self.goodPercent = Double(self.statsInfo.goodDays) / Double(self.statsInfo.totalDays)
                                self.okPercent = Double(self.statsInfo.okDays) / Double(self.statsInfo.totalDays)
                                self.badPercent = Double(self.statsInfo.badDays) / Double(self.statsInfo.totalDays)
                        
                            }

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
        
        self.goodPercent = 0.0
        self.okPercent = 0.0
        self.badPercent = 0.0
        
        self.statsInfo.dataLoaded = false
    }
} // Class
