//
//  ProgressBar.swift
//  byt8
//
//  Created by Will Sather on 7/2/21.
//

import SwiftUI

struct ProgressBar: View {
    
    @State var color: Color
    @State var percent: Double
    
    var body: some View {
        
        ZStack(alignment: .leading) {
                
            Capsule()
                .fill(Color.Clean)
                .frame(width: 90, height: 6)
       
            Capsule()
                .fill(self.color)
                .frame(width: 90*CGFloat(self.percent), height: 6, alignment: .leading)
        }
    }
}

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        ProgressBar(color: Color.Fresh, percent: 0.50)
    }
}
