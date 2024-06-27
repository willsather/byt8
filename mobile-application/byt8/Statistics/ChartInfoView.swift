//
//  ChartInfoView.swift
//  Bytes
//
//  Created by Will Sather on 6/15/21.
//

import SwiftUI

struct ChartInfoView: View {
    
    @State var name: String
    @State var progress: Double
    
    @State var color: Color = Color.Fresh

    var body: some View {
       
        VStack(spacing: 15) {
            
            ZStack {
                Ring(progress: 1.0)
                    .foregroundColor(Color.Clean)
                    .frame(height: 100)
                
                Ring(progress: self.progress)
                    .foregroundColor(self.color)
                    .frame(height: 100)
            }
            
            Text(name)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(self.color)
            
        } // VStack
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
        
    }
}
