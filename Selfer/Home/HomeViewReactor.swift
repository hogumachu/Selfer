//
//  HomeViewReactor.swift
//  Selfer
//
//  Created by 홍성준 on 2023/02/22.
//

import Foundation
import ReactorKit

final class HomeViewReactor: Reactor {
    
    enum Action {
        case refresh
    }
    
    enum Mutation {
        case reloadData
        case setLoading(Bool)
    }
    
    struct State {
        var sections: [HomeSection]
        var isLoading: Bool
    }
    
    init(questionRepository: QuestionRepository<QuestionEntity>) {
        self.questionRepository = questionRepository
    }
    
    let initialState: State = State(
        sections: [],
        isLoading: false
    )
    
    func mutate(action: Action) -> Observable<Mutation> {
        switch action {
        case .refresh:
            let startLoading = Observable<Mutation>.just(.setLoading(true))
            let endLoading = Observable<Mutation>.just(.setLoading(false))
            let reloadData = Observable<Mutation>.just(.reloadData)
            return .concat([startLoading, reloadData, endLoading])
        }
    }
    
    func reduce(state: State, mutation: Mutation) -> State {
        var newState = state
        switch mutation {
        case .reloadData:
            newState.sections = self.makeSections()
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return newState
    }
    
    private func makeSections() -> [HomeSection] {
        let items = self.questionRepository.getAll(where: nil).map { HomeItem.questionModel(.init(title: $0.question, subtitle: $0.answer)) }
        return [.init(items: items)]
    }
    
    private let questionRepository: QuestionRepository<QuestionEntity>
    
}
