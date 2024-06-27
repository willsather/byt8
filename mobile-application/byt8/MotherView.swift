//
//  MotherView.swift
//  byt8
//
//  Created by Will Sather on 6/17/21.
//

import SwiftUI

struct MotherView: View {
    
    @State var goToHome: Bool = false
    
    var body: some View {
        
        ZStack {
            if !goToHome {
                OnboardingView()
            } else {
                ContentView()
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.Name("Onboarding_Success")), perform: { _ in
            
            withAnimation(.linear(duration: 1.5)) { self.goToHome = true }
        })
    }
}

struct MotherView_Previews: PreviewProvider {
    static var previews: some View {
        MotherView()
    }
}
