//
//  SpecificStatsViewListItem.swift
//  byt8
//
//  Created by Will Sather on 7/2/21.
//

import SwiftUI

struct SpecificStatsViewListItem: View {
    
    @State var color: Color
    @State var percent: Double = 0.0
    @State var subTitle: String
    @State var icon: String
    
    var body: some View {
        
        HStack {
            Image(systemName: icon)
                .frame(width: 20)
                .foregroundColor(self.color)
                .padding(.leading, 15)
            
            Text(self.subTitle)
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(self.color)
                .padding(.leading, 10)
            
            Spacer()
            
            ProgressBar(color: self.color, percent: self.percent)
            
            Spacer()
            
            Text("\(Int(self.percent*100))%")
                .font(.title3)
                .fontWeight(.bold)
                .foregroundColor(self.color)
                .padding()
                .padding(.trailing, 15)
        }
    }
}
