//
//  DayOfWeekView.swift
//  byt8
//
//  Created by Will Sather on 7/4/21.
//

import SwiftUI

struct DayOfWeekView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var statsInfo: StatsInfo
    
    @State var sundayColor: Color
    @State var mondayColor: Color
    @State var tuesdayColor: Color
    @State var wednesdayColor: Color
    @State var thursdayColor: Color
    @State var fridayColor: Color
    @State var saturdayColor: Color
    
    var body: some View {
        
        VStack {
            HStack {
                DayIconView(date: "S", color: self.sundayColor)
                    .padding()
                DayIconView(date: "M", color: self.mondayColor)

                DayIconView(date: "T", color: self.tuesdayColor)
                    .padding()
                DayIconView(date: "W", color: self.wednesdayColor)

                DayIconView(date: "T", color: self.thursdayColor)
                    .padding()
                DayIconView(date: "F", color: self.fridayColor)
                
                DayIconView(date: "S", color: self.saturdayColor)
                    .padding()
            }
            
            Text("Day of Week")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.Fresh)
        }
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        .onAppear() {
            self.getColors()
        }
    }
    
    func getColors() {
        self.sundayColor = self.statsInfo.dayOfWeekSunday.getColor()
        self.mondayColor = self.statsInfo.dayOfWeekMonday.getColor()
        self.tuesdayColor = self.statsInfo.dayOfWeekTuesday.getColor()
        self.wednesdayColor = self.statsInfo.dayOfWeekWednesday.getColor()
        self.thursdayColor = self.statsInfo.dayOfWeekThursday.getColor()
        self.fridayColor = self.statsInfo.dayOfWeekFriday.getColor()
        self.saturdayColor = self.statsInfo.dayOfWeekSaturday.getColor()
    }
}
