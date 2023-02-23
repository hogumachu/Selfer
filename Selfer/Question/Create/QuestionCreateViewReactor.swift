//
//  QuestionCreateViewReactor.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import ReactorKit
import RxSwift

final class QuestionCreateViewReactor: Reactor {
    
    enum Action {
        case updateQuestion(String)
        case updateAnswer(String)
        case addButtonTap
    }
    
    enum Mutation {
        case setQuestion(String)
        case setAnswer(String)
        case setLoading(Bool)
        case createQuestion
        case updatePage
    }
    
    struct State {
        var question: String
        var answer: String
        var page: Int
        var isLoading: Bool
    }
    
    init(questionRepository: QuestionRepository<QuestionEntity>) {
        self.repository = questionRepository
    }
    
    let initialState: State = State(
        question: "",
        answer: "",
        page: 0,
        isLoading: false
    )
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .updateQuestion(let question):
            let setQuestion = Mutation.setQuestion(question)
            return .just(setQuestion)
            
        case .updateAnswer(let answer):
            let setAnswer = Mutation.setAnswer(answer)
            return .just(setAnswer)
            
        case .addButtonTap:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
//            let createQuestion = Observable<Mutation>.just(.createQuestion)
            let updatePage = Observable<Mutation>.just(.updatePage)
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            return .concat([startLoading, updatePage, endLoading])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .setQuestion(let question):
            newState.question = question
            
        case .setAnswer(let answer):
            newState.answer = answer
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
            
        case .createQuestion:
            let item = QuestionEntity(
                question: state.question,
                answer: state.answer,
                isComplete: false,
                createdAt: Date()
            )
            do {
                try self.repository.insert(item: item)
            } catch {
                
            }
            
        case .updatePage:
            newState.page = state.page == 0 ? 1 : 0
        }
        return newState
    }
    
    private let repository: QuestionRepository<QuestionEntity>
    
}
