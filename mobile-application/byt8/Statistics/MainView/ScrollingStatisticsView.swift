//
//  ScrollingStatisticsView.swift
//  byt8
//
//  Created by Will Sather on 6/20/21.
//

import SwiftUI

struct ScrollingStatisticsView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var statsInfo: StatsInfo
    
    @ObservedObject var specificDataGood: SpecificData = SpecificData(type: "Good")
    @ObservedObject var specificDataOk: SpecificData = SpecificData(type: "Ok")
    @ObservedObject var specificDataBad: SpecificData = SpecificData(type: "Bad")
    
    @ObservedObject var specificDataHealthy: SpecificDataSubject = SpecificDataSubject(questionCode: "healthy", answer: "Healthy")
    
    var body: some View {
            
        RefreshableScrollView(content: {
             
            // Top Primary Content
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 35, content: {
                
                NavigationLink(destination: SpecificDayView(color: Color.Fresh, dayType: "Good", specificDays: self.statsInfo.goodDays, totalDays: self.statsInfo.totalDays)
                                .environmentObject(specificDataGood)) {
                    
                    // Good Day Chart
                    ChartInfoView(name: "Good Days", progress: calcProgressTotal(param1: Double(self.statsInfo.goodDays), total: Double(self.statsInfo.totalDays)), color: Color.Fresh)
                }
                
                NavigationLink(destination: SpecificDayView(color: Color.Sunshine, dayType: "Ok", specificDays: self.statsInfo.okDays, totalDays: self.statsInfo.totalDays)
                                .environmentObject(specificDataOk)) {
                    
                    // Ok Day Chart
                    ChartInfoView(name: "Ok Days",progress: calcProgressTotal(param1: Double(self.statsInfo.okDays), total: Double(self.statsInfo.totalDays)), color: Color.Sunshine)
                }
                
                NavigationLink(destination: SpecificDayView(color: Color.Vermillion, dayType: "Bad", specificDays: self.statsInfo.badDays, totalDays: self.statsInfo.totalDays)
                                .environmentObject(specificDataBad)) {
                    
                    // Bad Day Chart
                    ChartInfoView(name: "Bad Days", progress: calcProgressTotal(param1: Double(self.statsInfo.badDays), total: Double(self.statsInfo.totalDays)), color: Color.Vermillion)
                }
                
                NavigationLink(destination: SpecificSubjectView(color: Color.Fresh, subject: "Healthy", questionCode: "Healthy", answer: "Healthy", specificDays: self.statsInfo.healthyDays, totalDays: self.statsInfo.totalDays)
                        .environmentObject(specificDataHealthy)) {

                    // Healthy Chart
                    ChartInfoView(name: "Healthy", progress: calcProgress(param1: Double(self.statsInfo.healthyDays), param2: Double(self.statsInfo.noHealthyDays)))
                }
                                
            }) // LazyVGrid
            .padding()
            .background(colorScheme == .light ? Color.Background : Color.BackgroundDark)
            
            // Day of Week
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 1), spacing: 35, content: {
                
                DayOfWeekView(sundayColor: self.statsInfo.dayOfWeekSunday.getColor(),
                              mondayColor: self.statsInfo.dayOfWeekMonday.getColor(),
                              tuesdayColor: self.statsInfo.dayOfWeekTuesday.getColor(),
                              wednesdayColor: self.statsInfo.dayOfWeekWednesday.getColor(),
                              thursdayColor: self.statsInfo.dayOfWeekThursday.getColor(),
                              fridayColor: self.statsInfo.dayOfWeekFriday.getColor(),
                              saturdayColor: self.statsInfo.dayOfWeekSaturday.getColor())
                
            }) // LazyVGrid
            .padding()
            .environmentObject(self.statsInfo)
            .background(colorScheme == .light ? Color.Background : Color.BackgroundDark)
                        
            BottomStatisticsGraphs()
                
        }, onRefresh: {control in
                        
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                // Do refresh work
                self.statsInfo.getData()
                                
                // End Refresh work
                control.endRefreshing()
            }
        })
        .background(colorScheme == .light ? Color.Background : Color.BackgroundDark)
    }
}
