//
//  NumberInfoView.swift
//  byt8
//
//  Created by Will Sather on 6/22/21.
//

import SwiftUI

struct NumberInfoView: View {
    
    @State var name: String
    @State var number: Int
    
    var body: some View {
        
        VStack(spacing: 15) {
            
            if (name == "Weather") {
                Text("\(number)°")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.Fresh)
                .multilineTextAlignment(.center)
            } else {
                Text("\(number)")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .foregroundColor(Color.Fresh)
                .multilineTextAlignment(.center)
            }
            
            Text("Average")
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.Fresh)
            
            Text(name)
                .font(.title2)
                .fontWeight(.medium)
                .foregroundColor(Color.Fresh)
                .padding(.vertical, -18)

        } // VStack
        .padding()
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(15)
    }
}

struct NumberInfoView_Previews: PreviewProvider {
    static var previews: some View {
        NumberInfoView(name: "Testing", number: 70)
    }
}
