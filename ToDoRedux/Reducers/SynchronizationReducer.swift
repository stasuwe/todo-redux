//
//  SynchronizationReducer.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum SynchronizationReducer {
  
  static func reducer(action: Action, state: SynchronizationState?) -> SynchronizationState {
    var state = state ?? SynchronizationState()
    
    switch action {
    case _ as SynchronizationActions.SynchronizeNewTodos:
      state.synchronizeNewTodos = !state.synchronizeNewTodos
    default: break
    }
    
    return state
  }
}
