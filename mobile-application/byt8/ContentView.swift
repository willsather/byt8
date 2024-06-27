//
//  ContentView.swift
//  byt8
//
//  Created by Will Sather on 6/17/21.
//

import SwiftUI
import UIKit
import Firebase

struct ContentView: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init() {
        UITabBar.appearance().backgroundColor = colorScheme == .light ? UIColor(Color.Background) : UIColor(Color.BackgroundDark)
    }
    
    var body: some View {
        TabView () {
            HomeView()
                .tabItem {
                    Image(systemName: "house")
                }
                .tag("Home")
            
            StatisticsView()
                .tabItem {
                    Image(systemName: "chart.bar")
                }
                .tag("Stats")

            ProfileView()
                .tabItem {
                    Image(systemName: "person")
                }
                .tag("Profile")
        }
        .accentColor(Color.Fresh)
        
    }
}

// Color Extension for Custom Colors
extension Color {
    static let Fresh = Color(red: 74 / 255, green: 189 / 255, blue: 172 / 255)
    static let Sunshine = Color(red: 247 / 255, green: 183 / 255, blue: 51 / 255)
    static let Vermillion = Color(red: 252 / 255, green: 74 / 255, blue: 26 / 255)
    static let Clean = Color(red: 223 / 255, green: 220 / 255, blue: 227 / 255)
    
    static let Background = Color(red: 243 / 255, green: 242 / 255, blue: 243 / 255)
    static let BackgroundDark = Color(red: 89 / 255, green: 89 / 255, blue: 89 / 255)
}
