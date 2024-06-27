//
//  StatisticsView.swift
//  Bytes
//
//  Created by Will Sather on 3/30/21.
//

import SwiftUI
import Firebase

struct StatisticsView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme

    @ObservedObject var statsInfo = StatsInfo()

    var body: some View {
        
        NavigationView {
        
            if !statsInfo.dataLoaded {
                ProgressView()
                
            } else {
                
                VStack {
                        Spacer()
                        ScrollingStatisticsView()
                            .padding(.top, 250)
                        Spacer()
                    }
                    .navigationTitle("Statistics")
                    .background(
                        Image(colorScheme == .light ? "statisticsBackground" : "statisticsBackgroundDark")
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    )
                    .edgesIgnoringSafeArea([.top])
                    .environmentObject(self.statsInfo)
            }
        }
        .onAppear() {
            self.statsInfo.getData()
        }
    }
}
