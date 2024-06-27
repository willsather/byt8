//
//  QuestionView.swift
//  Bytes
//
//  Created by Will Sather on 6/7/21.
//

import Foundation
import SwiftUI
import Firebase

var db: DatabaseReference!

struct QuestionView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @Binding var question: Question
    @Binding var answered: Int
    @Binding var submittedToday: Bool
    
    @State var selected = ""
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 22) {
            
            // Question
            Text(question.question!)
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(colorScheme == .light ? .black : .white)
                .padding(.top,25)
            
            // Options (Minimum two but up to 4
            
            // Answer 1
            Button(action: {submitAnswer(selection: question.optionA!)}, label: {
                Text(question.optionA!)
                    .foregroundColor(colorScheme == .light ? .black : .white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color.Fresh, lineWidth: 2)
                )
            })
            
            // Answer 2
            Button(action: {submitAnswer(selection: question.optionB!)}, label: {
                Text(question.optionB!)
                    .foregroundColor(colorScheme == .light ? .black : .white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                                    .stroke(Color.Fresh, lineWidth: 2)
                )
            })
            
            if (question.optionC != nil) {
                
                // Answer 3
                Button(action: {submitAnswer(selection: question.optionC!)}, label: {
                    Text(question.optionC!)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15)
                                .stroke(Color.Fresh, lineWidth: 2)
                    )
                })
            }
            
            if (question.optionD != nil) {
                
                // Answer 4
                Button(action: {submitAnswer(selection: question.optionD!)}, label: {
                    Text(question.optionD!)
                        .foregroundColor(colorScheme == .light ? .black : .white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(
                            RoundedRectangle(cornerRadius: 15).stroke(Color.Fresh, lineWidth: 3)
                    )
                })
            }
         
        // End of VStack
        }
        .padding()
        .background(colorScheme == .light ? Color.white : Color.BackgroundDark)
        .cornerRadius(25)
        
    } // some View
    
    func submitAnswer(selection: String) {
        
        // Increment Information
        question.completed = true
        answered += 1
        
        // Write Answer to firebase
        db = Database.database().reference()
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            
            if (error == nil) {
                
                guard let user = authResult?.user else { return }
                let uid = user.uid
                
                // Write Data to Realtime Database
                db.child("root").child("users").child(uid).child("data").child(getDateAsString()).child(question.questionCode!).setValue(selection)
                
                // Last question
                if (question.num == 8) {
                    submittedToday = true
                    
                    FirebaseAnalytics.Analytics.logEvent("questions_completed", parameters: nil)
                    AppReviewRequest.requestReviewIfNeeded()
                    submitExternalData()
                }
            }
            else {
                print("Authentication error")
            }

        }
        
    }
}
