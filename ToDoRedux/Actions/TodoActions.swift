//
//  TodoActions.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//
import ReSwift

enum TodoActions {
  struct Load: Action {
    let todos: [ToDo]
  }
  
  struct LoadingError: Action {
    let error: Error
  }
  
  struct Add: Action {
    let todo: ToDo
  }
  
  struct Archive: Action {
    let todo: ToDo
  }
  
  struct Delete: Action {
    let todo: ToDo
  }
  
  struct ToggleCompleted: Action {
    let todo: ToDo
  }
  
  struct ShowError: Action {
    let error: Error
  }
}
