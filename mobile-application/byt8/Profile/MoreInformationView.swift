//
//  MoreInformationView.swift
//  byt8
//
//  Created by Will Sather on 7/3/21.
//

import SwiftUI
import Firebase

struct MoreInformationView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    @State private var showingDeleteWarning = false
    
    var body: some View {
        
        ZStack {
            
            colorScheme == .light ? Color.Background.edgesIgnoringSafeArea(.all) : Color.BackgroundDark.edgesIgnoringSafeArea(.all)
            
            VStack {
                
                Text("More Information")
                    .font(.title)
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                
                Spacer()
                
                UpcomingFeaturesView()
                    .padding()
                
                Spacer()
                Spacer()
                
                Button(action: {
                    showingDeleteWarning.toggle()
                }, label: {
                    HStack {
                        Image(systemName: "trash")
                            .font(.title)
                        
                        Text("Delete all my data")
                            .font(.title3)
                            .bold()
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(Color.Vermillion)
                    .cornerRadius(40)
                })
                
                Spacer()
                
                HStack {
                    
                    Button(action: {
                        
                        let url = URL(string:"https://sather.ws")!
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                            UIApplication.shared.openURL(url)
                        }
                    }, label: {
                        Text("Developer Website")
                            .font(.footnote)
                            .foregroundColor(Color.Fresh)
                            .padding()
                    })
                    
                    Spacer()
                    
                    Button(action: {
                        
                        let url = URL(string:"https://www.byt8.app/privacy")!
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(url, options: [:], completionHandler: nil)
                        } else {
                            // Fallback on earlier versions
                            UIApplication.shared.openURL(url)
                        }
                    }, label: {
                        Text("Privacy Policy")
                            .font(.footnote)
                            .foregroundColor(Color.Fresh)
                            .padding()
                    })
                }
            }
        }
        .alert(isPresented: $showingDeleteWarning) {
            Alert(title: Text("Are your sure?"), message: Text("Please verify again that you want to delete all collected user data.  This will remove your data and the statistics associated with it."), primaryButton: .destructive(Text("Delete")) {
                
                FirebaseAnalytics.Analytics.logEvent("data_deleted", parameters: nil)
                deleteUserData()
            },
            secondaryButton: .cancel()
)
        }
    }
}

func deleteUserData() {
    
    // Delete User data from firebase
    db = Database.database().reference()
    
    Auth.auth().signInAnonymously() { (authResult, error) in
        
        if (error == nil) {
            
            guard let user = authResult?.user else { return }
            let uid = user.uid
            
            // Write Data to Realtime Database
            db.child("root").child("users").child(uid).child("data").removeValue()
            
        }
        else {
            print("Authentication error")
        }

    }

}

struct MoreInformationView_Previews: PreviewProvider {
    static var previews: some View {
        MoreInformationView()
    }
}
