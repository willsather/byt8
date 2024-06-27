//
//  QuestionViewModel.swift
//  Bytes
//
//  Created by Will Sather on 6/8/21.
//

import Foundation
import SwiftUI
import Firebase
import FirebaseFirestore
import FirebaseFirestoreSwift

class QuestionViewModel: ObservableObject {
    
    @Published var questions : [Question] = []
    
    func getQuestions() {
        
        // Only getting one set of questions
        
        let db = Firestore.firestore()
        
        db.collection("Questions").getDocuments { (snap, err) in
        
            guard let data = snap else { return }
            
            DispatchQueue.main.async {
                
                self.questions = data.documents.compactMap({ (doc) -> Question? in
                    return try? doc.data(as: Question.self)
                })
            }
        }
    }
}
