//
//  DayIconView.swift
//  byt8
//
//  Created by Will Sather on 7/5/21.
//

import SwiftUI

struct DayIconView: View {
    
    @State var date: String
    @State var color: Color
    
    var body: some View {
        VStack {
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(self.color)
            Text(date)
                .font(.title3)
                .foregroundColor(Color.black)
        }
    }
}

