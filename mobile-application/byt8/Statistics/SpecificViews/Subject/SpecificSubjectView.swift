//
//  SpecificDayView.swift
//  byt8
//
//  Created by Will Sather on 6/30/21.
//

import SwiftUI

struct SpecificSubjectView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var statsInfo: StatsInfo
    @EnvironmentObject var specificDataSubject: SpecificDataSubject

    @State var color: Color
    @State var subject: String
    @State var questionCode: String
    @State var answer: String
    @State var specificDays: Int
    @State var totalDays: Int
    
    var body: some View {
        
        RefreshableScrollView(content: {
            
            VStack {
                
                HStack {
                    
                    VStack {
                        
                        Text(subject)
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(self.color)
                            .padding([.leading])
                        
                        Text(self.specificDays == 1 ? "\(self.specificDays) day" : "\(self.specificDays) days")
                            .font(.title3)
                            .fontWeight(.semibold)
                            .foregroundColor(self.color)
                            .padding([.leading])
                    }
                    
                    Spacer()
                    Spacer()
                    Spacer()

                    ZStack {
                        Ring(progress: 1.0)
                            .foregroundColor(Color.Clean)
                            .frame(height: 100)
                        
                        Ring(progress: Double(self.specificDays)/Double(self.totalDays))
                            .foregroundColor(self.color)
                            .frame(height: 100)
                        
                    } // ZStack
                    
                } // HStack
                .padding()
                    
                SpecificStatsListSubjectView(dayType: self.questionCode, specificStats: self.specificDataSubject)
            }
            .background(colorScheme == .light ? Color.Background : Color.BackgroundDark)
            .ignoresSafeArea(edges: [.top, .bottom])
        },

        onRefresh: { control in
            
            // Do refresh work
            self.statsInfo.getData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                
                //self.specificDataSubject.getSpecificSubjectData(questionCode: self.subject, answer: self.answer)
                
                self.specificDays = self.statsInfo.getSpecificSubject(subject: self.subject)
                self.totalDays = self.statsInfo.totalDays
                
                // End Refresh work
                control.endRefreshing()
            }
        })
        .background(colorScheme == .light ? Color.Background : Color.BackgroundDark)
        .ignoresSafeArea(edges: [.top, .bottom])
        
    } // body
    
} // View
