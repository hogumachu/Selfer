//
//  QuestionObject.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import Foundation
import RealmSwift

final class QuestionObject: Object {
    
    @Persisted private(set) var question: String
    @Persisted private(set) var answer: String
    @Persisted private(set) var isComplete: Bool
    @Persisted private(set) var createdAt: Date
    
    convenience init(
        question: String,
        answer: String,
        isComplete: Bool,
        createAt: Date
    ) {
        self.init()
        self.question = question
        self.answer = answer
        self.isComplete = isComplete
        self.createdAt = createAt
    }
    
    var model: QuestionEntity {
        get {
            QuestionEntity(
                question: self.question,
                answer: self.answer,
                isComplete: self.isComplete,
                createAt: self.createdAt
            )
        }
    }
    
}
