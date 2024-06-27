//
//  QuestionViewModal.swift
//  Bytes
//
//  Created by Will Sather on 6/8/21.
//

import SwiftUI

struct QuestionViewModal: View {
    
    @Environment(\.colorScheme) var colorScheme: ColorScheme
    @Environment(\.presentationMode) var present
    
    @Binding var answered: Int
    @Binding var submittedToday: Bool

    @StateObject var data = QuestionViewModel()
    
    var body: some View {
        
        ZStack {
            
            if data.questions.isEmpty {
                ProgressView()
            } else {
                if (answered < data.questions.count) {
                    VStack {
                        
                        ZStack {
                            Capsule()
                                .fill(Color.gray.opacity(0.5))
                                .frame(height: 6)
                            
                            Capsule()
                                .fill(Color.Vermillion)
                                .frame(width: progress(), height: 6)
                        }
                        .padding(.top)

                        Spacer()
                        
                        ZStack {
                            // Iterate over questions and create new view
                            ForEach(data.questions.reversed().indices) { index in
                                
                                QuestionView(question: $data.questions[index], answered: $answered, submittedToday: $submittedToday)
                                    .offset(x: data.questions[index].completed ? 1000 : 0)
                                    .rotationEffect(.init(degrees: data.questions[index].completed ? 10 : 0))
                            }
                        }
                        
                        Spacer()
                    }
                }
            
            }
        }
        .background(colorScheme == .light ? Color.white : Color.BackgroundDark)
        .edgesIgnoringSafeArea([.bottom])
        .onAppear(perform: {
            data.getQuestions()
            answered = 0
        })
    }
    
    func progress()->CGFloat {
        
        let fraction = CGFloat(answered) / CGFloat(data.questions.count)
                
        let width = UIScreen.main.bounds.width - 30
                    
        return fraction*width
    }
    
}
