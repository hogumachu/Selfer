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
        var isLoading: Bool
    }
    
    let initialState: State = State(isLoading: false)
    
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
            print("# TODO: - Reload Data")
            
        case .setLoading(let isLoading):
            newState.isLoading = isLoading
        }
        return state
    }
    
}