//
//  TodosReducer.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum TodosReducer {
  
  static func reducer(action: Action, state: TodosState?) -> TodosState {
    var state = state ?? TodosState()
    
    switch action {
    case let addActions as TodoActions.Load:
      state.todos = addActions.todos
    case let addAction as TodoActions.Add:
      state.todos.append(addAction.todo)
    case let archiveAction as TodoActions.Archive:
      guard let index = state.todos.index(of: archiveAction.todo) else { break }
      state.todos[index].archive()
    case let deleteAction as TodoActions.Delete:
      guard let index = state.todos.index(of: deleteAction.todo) else { break }
      state.todos.remove(at: index)
    case let toggleCompletedAction as TodoActions.ToggleCompleted:
      guard let index = state.todos.index(of: toggleCompletedAction.todo) else { break }
      state.todos[index].toogleComplete()
    case let loadingErrorAction as TodoActions.LoadingError:
      state.loadingError = loadingErrorAction.error
    default: break
    }
    return state
  }
}
