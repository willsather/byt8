//
//  OnboardingInfoView.swift
//  byt8
//
//  Created by Will Sather on 6/17/21.
//

import SwiftUI

struct OnboardingInfoView: View {
    
    @State var data: OnboardingData
    
    var body: some View {
        
        VStack {
            
            Spacer()
            Image(data.image)
                .resizable()
                .scaledToFit()
                .padding(.bottom, 50)
            
            Text(data.heading)
                //.font(.system(size: 25, design: .rounded))
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .fontWeight(.bold)
            
            Rectangle()
                .frame(width: 50, height: 5)
                .foregroundColor(Color.Fresh)
                .padding()
            
            Text(data.body)
                .font(.body)
                .fontWeight(.medium)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()

    }
}

