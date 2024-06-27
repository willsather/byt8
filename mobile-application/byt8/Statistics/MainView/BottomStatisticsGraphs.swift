//
//  BottomStatisticsGraphs.swift
//  byt8
//
//  Created by Will Sather on 6/30/21.
//

import SwiftUI

struct BottomStatisticsGraphs: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @EnvironmentObject var statsInfo: StatsInfo
    
    @ObservedObject var specificDataProductive: SpecificDataSubject = SpecificDataSubject(questionCode: "productive", answer: "Yes")
    @ObservedObject var specificDataReading: SpecificDataSubject = SpecificDataSubject(questionCode: "read", answer: "Yes")
    @ObservedObject var specificDataLearning: SpecificDataSubject = SpecificDataSubject(questionCode: "learning", answer: "Yes")
    @ObservedObject var specificDataWorkout: SpecificDataSubject = SpecificDataSubject(questionCode: "workout", answer: "Yes")
    @ObservedObject var specificDataNewPeople: SpecificDataSubject = SpecificDataSubject(questionCode: "new_person", answer: "Yes")
    @ObservedObject var specificDataDrinking: SpecificDataSubject = SpecificDataSubject(questionCode: "party", answer: "Yes")

    var body: some View {
        
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 35, content: {
            
            NavigationLink(destination: SpecificSubjectView(color: Color.Fresh, subject: "Productive", questionCode: "productive", answer: "Yes", specificDays: self.statsInfo.productiveDays, totalDays: self.statsInfo.totalDays)
                    .environmentObject(specificDataProductive)) {

                // Productive Chart
                ChartInfoView(name: "Productive", progress: calcProgress(param1: Double(self.statsInfo.productiveDays), param2: Double(self.statsInfo.noProductiveDays)))
            }

            NavigationLink(destination: SpecificSubjectView(color: Color.Fresh, subject: "Reading", questionCode: "read", answer: "Yes", specificDays: self.statsInfo.readDays, totalDays: self.statsInfo.totalDays)
                    .environmentObject(specificDataReading)) {

                // Reading Chart
                ChartInfoView(name: "Reading", progress: calcProgress(param1: Double(self.statsInfo.readDays), param2: Double(self.statsInfo.noReadDays)))
            }
            
            // Steps Number
            let avg_steps = calcAverageSteps(arr: self.statsInfo.steps)
            NumberInfoView(name: "Steps", number: avg_steps)
            
            // Weather Number
            let avg_temp = calcAverageTemperature(arr: self.statsInfo.temperatures)
            NumberInfoView(name: "Weather", number: Int(avg_temp))
            
            
            NavigationLink(destination: SpecificSubjectView(color: Color.Fresh, subject: "Learning", questionCode: "learning", answer: "Yes", specificDays: self.statsInfo.learningDays, totalDays: self.statsInfo.totalDays)
                    .environmentObject(specificDataLearning)) {

                // Learning Chart
                ChartInfoView(name: "Learning", progress: calcProgress(param1: Double(self.statsInfo.learningDays), param2: Double(self.statsInfo.noLearningDays)))
            }
            

            NavigationLink(destination: SpecificSubjectView(color: Color.Fresh, subject: "Workout", questionCode: "workout", answer: "Yes", specificDays: self.statsInfo.workoutDays, totalDays: self.statsInfo.totalDays)
                    .environmentObject(specificDataWorkout)) {

                // Workouts Chart
                ChartInfoView(name: "Workout", progress: calcProgress(param1: Double(self.statsInfo.workoutDays), param2: Double(self.statsInfo.noWorkoutDays)))
            }

            NavigationLink(destination: SpecificSubjectView(color: Color.Fresh, subject: "New People", questionCode: "new_person", answer: "Yes", specificDays: self.statsInfo.newPersondays, totalDays: self.statsInfo.totalDays)
                    .environmentObject(specificDataNewPeople)) {

                // New People Chart
                ChartInfoView(name: "New People",progress: calcProgress(param1: Double(self.statsInfo.newPersondays), param2: Double(self.statsInfo.noNewPersondays)))
            }
            
            NavigationLink(destination: SpecificSubjectView(color: Color.Fresh, subject: "Drinking", questionCode: "party", answer: "Yes", specificDays: self.statsInfo.partyDays, totalDays: self.statsInfo.totalDays)
                    .environmentObject(specificDataDrinking)) {

                // Party Chart
                ChartInfoView(name: "Drinking", progress: calcProgress(param1: Double(self.statsInfo.partyDays), param2: Double(self.statsInfo.noPartyDays)))
            }
        }) // LazyVGrid
        .padding()
        .background(colorScheme == .light ? Color.Background : Color.BackgroundDark)
    }
}
