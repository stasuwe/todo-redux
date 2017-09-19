//
//  ApplicationState.swift
//  ToDoRedux
//
//  Created by Sarychev Stanislav on 06.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

struct ApplicationState: StateType {
  var todosState: TodosState = TodosState()
  var sortingState: SortingState = SortingState()
  var synchronizationState: SynchronizationState = SynchronizationState()
}

struct TodosState: StateType {
  var todos: [ToDo] = []
  var loadingError: Error? = nil
}

struct SortingState: StateType {
  var sortingType: SortingType = .completed
  var sortingOrder: SortingOrder = .asc
}

struct SynchronizationState: StateType {
  var synchronizeNewTodos: Bool = false
}

enum SortingType {
  case completed
  case uncompleted
  case date
}

enum SortingOrder {
  case asc
  case desc
}
