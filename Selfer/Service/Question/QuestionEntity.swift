//
//  QuestionEntity.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import Foundation
import RealmSwift

final class QuestionEntity {
    
    var question: String
    var answer: String
    var isComplete: Bool
    var createdAt: Date
    
    init(question: String, answer: String, isComplete: Bool, createdAt: Date) {
        self.question = question
        self.answer = answer
        self.isComplete = isComplete
        self.createdAt = createAt
    }
    
}

extension QuestionEntity: Entity {
    
    private var object: QuestionObject {
        let object = QuestionObject(question: self.question, answer: self.answer, isComplete: self.isComplete, createdAt: self.createdAt)
        return object
    }
    
    func toObject() -> QuestionObject {
        self.object
    }
    
}
