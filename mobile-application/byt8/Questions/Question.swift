//
//  Question.swift
//  Bytes
//
//  Created by Will Sather on 6/8/21.
//

import Foundation
import SwiftUI
import FirebaseFirestoreSwift

struct Question: Identifiable, Codable {
    
    // Fetch Doc ID from Firebase
    @DocumentID var id: String?
    
    // Data
    var question: String?
    var optionA: String?
    var optionB: String?
    var optionC: String?
    var optionD: String?
    var questionCode: String?
    var num: Int?

    
    // Logistics
    var completed = false
    
    enum CodingKeys: String,CodingKey {
        case question
        case num
        case questionCode
        case optionA = "a"
        case optionB = "b"
        case optionC = "c"
        case optionD = "d"
    }
}
