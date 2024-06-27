//
//  ProfileInfoView.swift
//  byt8
//
//  Created by Will Sather on 6/17/21.
//

import SwiftUI
import Firebase

struct ProfileInfoView: View {
    
    @EnvironmentObject var profile: Profile
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @State private var localNotifications = false
    @State private var disableNotifications = false
    
    @Binding var stateFirstName: String
    @Binding var stateLastName: String
    @Binding var stateBirthday: Date
    
    @State var hideSaveButton: Bool

    var body: some View {
        
        VStack {
                        
            // First Name
            HStack {
                Text("First Name:")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading, 35)
                
                TextField("", text: $stateFirstName)
                    .font(.title2)
                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                    .padding(.trailing, 35)
                    .disableAutocorrection(true)
            }
            .foregroundColor(colorScheme == .light ? Color.black : Color.Fresh)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width-50, height: 5)
                .foregroundColor(Color.Fresh)
                .padding(.leading, 35)
                .padding(.trailing, 35)
                .padding(.bottom, 30)
            
            // Last Name
            HStack {
                Text("Last Name:")
                    .font(.title3)
                    .fontWeight(.bold)
                    .padding(.leading, 35)
                
                TextField("", text: $stateLastName)
                    .font(.title2)
                    .padding(.trailing, 35)
                    .foregroundColor(colorScheme == .light ? Color.black : Color.white)
                    .disableAutocorrection(true)
            }
            .foregroundColor(colorScheme == .light ? Color.black : Color.Fresh)
            
            Rectangle()
                .frame(width: UIScreen.main.bounds.width-50, height: 5)
                .foregroundColor(Color.Fresh)
                .padding(.leading, 35)
                .padding(.trailing, 35)
            
            // Age
            HStack {
            
                DatePicker(
                    selection: $stateBirthday,
                    in: ...Date().subtract(years: 13),
                    displayedComponents: [.date],
                    label: {
                        Text("Birthday")
                            .font(.title3)
                            .fontWeight(.bold)
                            .padding(.leading, 35)
                })
                .foregroundColor(colorScheme == .light ? Color.black : Color.Fresh)
                .onTapGesture { hideKeyboard() }
            }
            .padding(.top)
            .padding(.trailing, 35)
            
            // Notification Toggle
            Toggle(isOn: $localNotifications, label: {

                Text("Notifications")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(colorScheme == .light ? Color.black : Color.Fresh)
                    .padding(.leading, 35)
            })
            .toggleStyle(SwitchToggleStyle(tint: Color.Fresh))
            .padding(.top)
            .padding(.trailing, 35)
            .onChange(of: localNotifications, perform: { value in
                hideKeyboard()
                registerForPushNotifications()
                
                UNUserNotificationCenter.current().getNotificationSettings(completionHandler: { permission in
                    
                    print("Permission Authorized Status: \(permission.authorizationStatus.rawValue)")
                    
                    if permission.authorizationStatus == UNAuthorizationStatus.denied  {
                        modifyNotifications(value: false)
                        localNotifications = false
                        disableNotifications = true
                        print("Disabled Button")
                    } else {
                        modifyNotifications(value: value)
                        print("Enabled Toggle")
                    }
                })
            })
            .disabled(self.disableNotifications)
            
            if (self.disableNotifications) {
                Text("In order to get notifications, please enable push notifications in settings and reload application")
                    .font(.footnote)
                    .padding(.leading, 35)
                    .padding(.trailing, 35)
                    .multilineTextAlignment(.center)
            }
            
            if (!self.hideSaveButton) {
                                
                Button(action: {
                    hideKeyboard()
                    self.profile.saveProfile(stateFirstName: stateFirstName, stateLastName: stateLastName, stateBirthday: stateBirthday)
                }) {
                    
                    HStack {
                        Image(systemName: "checkmark")
                            .font(.title)
                        Text("   Save   ")
                            .font(.title3)
                            .bold()
                            .foregroundColor(Color.white)
                    }
                    .padding()
                    .foregroundColor(.white)
                    .background(stateFirstName.isEmpty ? Color.Clean : Color.Fresh)
                    .cornerRadius(40)
                }
                .disabled(stateFirstName.isEmpty)
                .padding(.top, 35)
                .padding()
            }
        }
        .ignoresSafeArea(.keyboard)
        .onAppear() {
            self.localNotifications = UserDefaults.standard.bool(forKey: "notifications")
        }
    }
}


func modifyNotifications(value: Bool) {
    
    // Write Answer to firebase
    db = Database.database().reference()
    
    // Write new FCM Token to Database
    Auth.auth().signInAnonymously() { (authResult, error) in
        
        if (error == nil) {
            
            guard let user = authResult?.user else { return }
            let uid = user.uid
                                        
            // Write Data to Realtime Database
            db.child("root").child("users").child(uid).child("fcm").child("notify").setValue(value)
            UserDefaults.standard.set(value, forKey: "notifications")
        }
        else {
            print("Authentication error")
        }
        
    } // End Auth
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
