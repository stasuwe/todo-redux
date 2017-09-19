//
//  ApplicationReducer.swift
//  ToDoRedux
//
//  Created by Sarychev Stanislav on 06.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum ApplicationReducer {
  static func reducer(action: Action, state: ApplicationState?) -> ApplicationState {
    return ApplicationState(
      todosState: TodosReducer.reducer(action: action, state: state?.todosState),
      sortingState: SortingReducer.reducer(action: action, state: state?.sortingState),
      synchronizationState: SynchronizationReducer.reducer(action: action, state: state?.synchronizationState)
    )
  }
}
