//
//  OnboardingView.swift
//  byt8
//
//  Created by Will Sather on 6/17/21.
//

import SwiftUI

struct OnboardingView: View {
    
    //@Environment(\.colorScheme) var colorScheme: ColorScheme
    
    init() {
        UIPageControl.appearance().currentPageIndicatorTintColor = UIColor(Color.Sunshine)
        UIPageControl.appearance().pageIndicatorTintColor = UIColor(Color.Fresh)

        //UIPageControl.appearance().pageIndicatorTintColor = colorScheme == .light ? UIColor.black.withAlphaComponent(0.3) : //UIColor.white.withAlphaComponent(0.3)
    }
    
    var body: some View {
        
        ScrollView {
            
            TabView {
                                
                OnboardingInfoView(data: OnboardingData(image: "checkbox", heading: "Daily Reflection", body: "By only taking 2 minutes a day, you can start gathering the highs, lows, and key factors of your day, while we safely secure your data in the cloud."))
                
                OnboardingInfoView(data: OnboardingData(image: "graphs", heading: "Summarized Data", body: "Using the data we save into the cloud for you, we are able to give you a sleek summary of how your days are going using the statistics page."))
                
                OnboardingInfoView(data: OnboardingData(image: "analytics", heading: "Smarter Analytics", body: "Get more insights and smarter, data driven intuition that gives you a granular level of data and the correlations of activities on outcome of your day"))
                
                FirstProfileView()
            }
            .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
            .tabViewStyle(PageTabViewStyle())
            
        }
        .edgesIgnoringSafeArea(.all)        
    }
}

struct OnboardingData {
    var image: String
    var heading: String
    var body: String
}


struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
