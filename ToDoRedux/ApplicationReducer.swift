//
//  ApplicationReducer.swift
//  ToDoRedux
//
//  Created by Sarychev Stanislav on 06.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum Reducers {
    
    static func applicationReducer(action: Action, state: ApplicationState?) -> ApplicationState {
        var state = state ?? ApplicationState()
        
        switch action {
        case let addAction as AddAction:
            state.todos.insert(addAction.todo, at: 0)
        case let changeSortAction as ChangeSortAction:
            state.sortingType = changeSortAction.sortingType
        default: break
        }
        
        return state
    }
}

struct AddAction: Action {
    let todo: ToDo
}

struct ChangeSortAction: Action {
    let sortingType: SortingType
}

