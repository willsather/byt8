//
//  EntryAddedView.swift
//  Bytes
//
//  Created by Will Sather on 6/14/21.
//

import SwiftUI

struct EntryAddedView: View {
    
    @ObservedObject var profile : Profile = Profile()
    
    @State var hoursLeft: Int = 24 - Calendar.current.component(.hour, from: Date())
    @State var progress: Double = (1.0 - (Double(24 - Calendar.current.component(.hour, from: Date())))/24.0)
    
    var body: some View {
        
        VStack {
            
            Text("Hello \(self.profile.first_name), hope you're having a good day!")
                .font(.title2)
                .padding()
                .padding(.bottom, 125)
                .multilineTextAlignment(.center)
            
            ZStack {
                HalfRing(progress: .constant(1.0))
                    .foregroundColor(Color.Clean)
                    .frame(height: 100)
                HalfRing(progress: $progress)
                    .foregroundColor(Color.Fresh)
                    .frame(height: 100)
                Text("\(self.hoursLeft) hours")
                    .font(.title2)
                    .fontWeight(.heavy)
                    .foregroundColor(Color.Fresh)
            }
            
            Text("Come back tomorrow to submit again")
        }
    }
}

struct EntryAddedView_Previews: PreviewProvider {
    static var previews: some View {
        EntryAddedView()
    }
}

