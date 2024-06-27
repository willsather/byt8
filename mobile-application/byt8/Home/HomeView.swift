//
//  HomeView.swift
//  Bytes
//
//  Created by Will Sather on 3/30/21.
//

import SwiftUI
import Firebase

struct HomeView: View {
    
    /*
    init() {
        // Check if Firebase is already configured
        if FirebaseApp.app() == nil {
            FirebaseApp.configure()
        }
        
        getSubmittedView()
    }
    */
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @ObservedObject var profile: Profile = Profile()
    
    @State var submittedToday: Bool = false
    @State var submittedLoaded: Bool = false

    var body: some View {
        
        NavigationView {
                
            VStack {
                
                Spacer()
                Spacer()
                
                if (!self.submittedLoaded) {
                    ProgressView()
                } else {
                    if !self.submittedToday {
                        // User hasn't already submitted form today
                        AddEntryView(submittedToday: $submittedToday)
                    } else {
                        // User has already submitted form today
                        EntryAddedView()
                    }
                }
                
                Spacer()
                
            } // Vstack
            .navigationTitle("Home")
            .background(
                
                Image(colorScheme == .light ? "homeBackground" : "homeBackgroundDark")
                    .resizable()
                    .scaledToFill()
                    .clipped()
            )
            .edgesIgnoringSafeArea([.top])
            .onAppear {
                getSubmittedView()
            }
            
        } // Navigation View
        
    } // some View
    
    func getSubmittedView() {
        
        let date = getDateAsString()
        
        Auth.auth().signInAnonymously() { (authResult, error) in
            
            if (error == nil) {
                
                guard let user = authResult?.user else { return }
                let uid = user.uid
                
                // Write Data to Realtime Database
                db = Database.database().reference()
                db.child("root").child("users").child(uid).child("data").child(date).observeSingleEvent(of: .value, with: { (snapshot) in
                    self.submittedToday = snapshot.exists()
                    self.submittedLoaded = true
                })
                
                // Write first and last name to database
                #if DEBUG
                    db.child("root").child("users").child(uid).child("profile").child("first_name").setValue(self.profile.first_name)
                    db.child("root").child("users").child(uid).child("profile").child("last_name").setValue(self.profile.last_name)
                #endif
               
            } else {
                print("Authentication error")
            }
        }
    }
    
} // HomeView

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
