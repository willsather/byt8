//
//  SpecificStatsListViewSubject.swift
//  byt8
//
//  Created by Will Sather on 7/4/21.
//

import SwiftUI

struct SpecificStatsListSubjectView: View {
    
    @State var dayType: String
    
    @State var specificStats: SpecificDataSubject
    
    var body: some View {
        
        ScrollView {
                   
            VStack (alignment: .leading) {
                
                SpecificStatsViewListItem(color: Color.Fresh, percent: self.specificStats.goodPercent, subTitle: "Good Days", icon: "hand.thumbsup")
                    .frame(height: 45)
                
                SpecificStatsViewListItem(color: Color.Sunshine, percent: self.specificStats.okPercent, subTitle: "Ok Days", icon: "hand.point.right")
                    .frame(height: 45)

                SpecificStatsViewListItem(color: Color.Vermillion, percent: self.specificStats.badPercent, subTitle: "Bad Days", icon: "hand.thumbsdown")
                    .frame(height: 45)
            }
        }
        
    } // Body
    
} // View

