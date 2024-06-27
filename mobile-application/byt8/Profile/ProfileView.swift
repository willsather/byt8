//
//  ProfileView.swift
//  Bytes
//
//  Created by Will Sather on 3/30/21.
//

import SwiftUI
import Foundation

struct ProfileView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @ObservedObject var profile: Profile = Profile()
    
    @State var stateFirstName: String = ""
    @State var stateLastName: String = ""
    @State var stateBirthday: Date = Date()

    @State var disabledButton: Bool = false
    
    var body: some View {
        NavigationView {
            
            VStack {
                Spacer()
                Spacer()
                ProfileInfoView(stateFirstName: $stateFirstName, stateLastName: $stateLastName, stateBirthday: $stateBirthday, hideSaveButton: false)
                    .environmentObject(profile)
                Spacer()
                HStack {
                    Spacer()
                    
                    NavigationLink(destination: MoreInformationView()) {
                        
                        Text("More Information")
                            .font(.footnote)
                            .foregroundColor(Color.Fresh)
                            .padding(.trailing, 25)
                    }
                }
            } // VStack
            .padding()
            .padding(.top, 90)
            .navigationTitle("Profile")
            .ignoresSafeArea(.keyboard)
            .background(
                Image(colorScheme == .light ? "profileBackground" : "profileBackgroundDark")
                    .resizable()
                    .scaledToFill()
                    .clipped()
                    .ignoresSafeArea(.keyboard)
            )
            .edgesIgnoringSafeArea([.top])
            .onAppear() {
                self.stateFirstName = profile.first_name
                self.stateLastName = profile.last_name
                self.stateBirthday = profile.birthday
            }
            
            Spacer()
        
        } // Navigation View
        .ignoresSafeArea(.keyboard)

    } // some View
    
} // ProfileView
