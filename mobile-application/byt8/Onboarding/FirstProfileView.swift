//
//  FirstProfileView.swift
//  byt8
//
//  Created by Will Sather on 6/17/21.
//

import SwiftUI

struct FirstProfileView: View {
    
    @ObservedObject var profile = Profile(first: "", last: "", birthday: Date())
    
    @State var stateFirstName: String = ""
    @State var stateLastName: String = ""
    @State var stateBirthday: Date = Date()
    
    var body: some View {
        
        VStack {
                        
            Spacer()
            
            ProfileInfoView(stateFirstName: $stateFirstName, stateLastName: $stateLastName, stateBirthday: $stateBirthday, hideSaveButton: true)
                .accentColor(Color.Fresh)
            
            Spacer()
            
            SliderView(stateFirstName: $stateFirstName, stateLastName: $stateLastName, stateBirthday: $stateBirthday)
            
            Spacer()
            
        }
        .environmentObject(profile)

    }
}

struct FirstProfileView_Previews: PreviewProvider {
    static var previews: some View {
        FirstProfileView()
    }
}
