//
//  AddEntryView.swift
//  Bytes
//
//  Created by Will Sather on 6/14/21.
//

import SwiftUI
import Firebase

struct AddEntryView: View {
    
    @State private var showQuestionView: Bool = false
    @State var profile : Profile = Profile()
    @State var today = Date()
    @State var answered = 0
    
    @Binding var submittedToday: Bool
    
    var body: some View {
        
        VStack {
            
            if (profile.first_name.trimmingCharacters(in: .whitespacesAndNewlines) == "") {
                Text("Hello, how is your day?")
                    .font(.title2)
                    .padding()
                    .padding(.bottom, 100)
            } else {
                Text("Hello \(profile.first_name), how is your day?")
                    .font(.title2)
                    .padding(.bottom, 100)
                    .multilineTextAlignment(.center)
            }

            Button(action: {
                showQuestionView = true
                FirebaseAnalytics.Analytics.logEvent("questions_started", parameters: nil)
            }) {
                HStack {
                    Image(systemName: "plus")
                        .font(.title)
                    Text("   New Entry   ")
                        .font(.title3)
                        .bold()
                        .foregroundColor(Color.white)
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.Fresh)
                .cornerRadius(40)
            }
            .sheet(isPresented: $showQuestionView) {
                QuestionViewModal(answered: $answered, submittedToday: $submittedToday)
            }
               
            Text("Add submission for \(today, style: .date)")
                .padding()
                .multilineTextAlignment(.center)
            
        }
    }
}

struct AddEntryView_Previews: PreviewProvider {
    static var previews: some View {
        AddEntryView(submittedToday: .constant(false))
    }
}
