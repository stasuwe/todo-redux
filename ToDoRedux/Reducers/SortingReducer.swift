//
//  SortingReducer.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum SortingReducer {
  
  static func reducer(action: Action, state: SortingState?) -> SortingState {
    var state = state ?? SortingState()
    
    switch action {
    case let changeSortingTypeAction as SortingActions.ChangeSortingType:
      state.sortingType = changeSortingTypeAction.sortingType
    default: break
    }
    
    return state
  }
}

