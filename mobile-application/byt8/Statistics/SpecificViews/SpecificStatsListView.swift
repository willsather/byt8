//
//  SpecificStatsListView.swift
//  byt8
//
//  Created by Will Sather on 7/2/21.
//

import SwiftUI

struct SpecificStatsListView: View {
    
    @State var color: Color
    @State var dayType: String
    
    @State var specificStats: SpecificData
    
    var body: some View {
        
        ScrollView {
                   
            VStack (alignment: .leading) {
                
                SpecificStatsViewListItem(color: self.color, percent: self.specificStats.healthyPercent, subTitle: "Healthy", icon: "cross.case")
                    .frame(height: 45)
                
                SpecificStatsViewListItem(color: self.color, percent: self.specificStats.productivePercent, subTitle: "Productive", icon: "paperclip")
                    .frame(height: 45)

                SpecificStatsViewListItem(color: self.color, percent: self.specificStats.readingPercent, subTitle: "Reading", icon: "text.book.closed.fill")
                    .frame(height: 45)

                SpecificStatsViewListItem(color: self.color, percent: self.specificStats.learningPercent, subTitle: "Learning", icon: "graduationcap.fill")
                    .frame(height: 45)

                SpecificStatsViewListItem(color: self.color, percent: self.specificStats.workoutPercent, subTitle: "Workout", icon: "bicycle")
                    .frame(height: 45)

                SpecificStatsViewListItem(color: self.color, percent: self.specificStats.newPeoplePercent, subTitle: "New People", icon: "person.2.fill")
                    .frame(height: 45)

                SpecificStatsViewListItem(color: self.color, percent: self.specificStats.drinkingPercent, subTitle: "Drinking", icon: "sparkles")
                    .frame(height: 45)
            }
        }
        
    } // Body
    
} // View

