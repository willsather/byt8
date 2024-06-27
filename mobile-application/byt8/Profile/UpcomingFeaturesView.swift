//
//  UpcomingFeaturesView.swift
//  byt8
//
//  Created by Will Sather on 7/6/21.
//

import SwiftUI

struct UpcomingFeaturesView: View {
    var body: some View {
        
        HStack {
            Text("Upcoming Features")
            .font(.title2)
            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
            
            Spacer()
        }
        
        Text("* Pick and choose from a variety of questions\n\n* Cross device data management cloud login system\n\n* Integrate sleep data into questions and statistics")
            .font(.title3)
    }
}

struct UpcomingFeaturesView_Previews: PreviewProvider {
    static var previews: some View {
        UpcomingFeaturesView()
    }
}
