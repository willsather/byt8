//
//  SliderView.swift
//  byt8
//
//  Created by Will Sather on 6/17/21.
//

import SwiftUI

struct SliderView: View {
    
    @State var maxWidth = UIScreen.main.bounds.width - 100
    @State var offset: CGFloat = 0
    
    @EnvironmentObject var profile: Profile
    
    @Binding var stateFirstName: String
    @Binding var stateLastName: String
    @Binding var stateBirthday: Date

    var body: some View {
        
        ZStack {
            Capsule()
                .fill(stateFirstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? Color.Clean.opacity(0.2): Color.Fresh.opacity(0.2))
            
            Text("SWIPE TO SAVE")
                .fontWeight(.semibold)
                .foregroundColor(stateFirstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? Color.Clean: Color.Fresh)
                .padding(.leading, 30)
            
            // Background Fill
            HStack {
                Capsule()
                    .fill(stateFirstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? Color.Clean: Color.Fresh)
                    .frame(width: calculateWidth() + 65)
                
                Spacer(minLength: 0)
            }
            
            HStack {
                
                ZStack {
                    Image(systemName: "chevron.right")
                    Image(systemName: "chevron.right")
                        .offset(x: -10)
                }
                .foregroundColor(.white)
                .offset(x: 5)
                .frame(width: 65, height: 65)
                .background(stateFirstName.trimmingCharacters(in: .whitespacesAndNewlines) == "" ? Color.Clean: Color.Fresh)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .offset(x: offset)
                .gesture(DragGesture().onChanged(onChanged(value:))
                            .onEnded(onEnd(value:)))
                
                Spacer()
            }
        }
        .frame(width: maxWidth, height: 65)
        .padding(.bottom)
    }
    
    func calculateWidth() -> CGFloat {
        let percent = offset/maxWidth
        return percent*maxWidth
    }
    
    
    func onChanged(value: DragGesture.Value) {
        if (value.translation.width > 0 && offset <= maxWidth-65) {
            offset = value.translation.width
        }
    }
    
    func onEnd(value: DragGesture.Value) {
        
        withAnimation(Animation.easeOut(duration: 0.3)) {
            if (offset > 130 && stateFirstName.trimmingCharacters(in: .whitespacesAndNewlines) != "") {
                
                // Complete Slider
                offset = maxWidth-65
                
                // Save user profile
                self.profile.saveProfile(stateFirstName: stateFirstName, stateLastName: stateLastName, stateBirthday: stateBirthday)
                
                UserDefaults.standard.set(true, forKey: "didLaunchBefore")
                
                let appDelegate = UIApplication.shared.delegate as! AppDelegate
                appDelegate.registerForHealthKit()
                
                // Notify User
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.35) {
                    NotificationCenter.default.post(name: NSNotification.Name("Onboarding_Success"), object: nil)
                }
            }
            else {
                // Set slider back to left
                offset = 0
            }
        }
    }
}
