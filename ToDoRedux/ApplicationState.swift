//
//  ApplicationState.swift
//  ToDoRedux
//
//  Created by Sarychev Stanislav on 06.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

struct ApplicationState: StateType {
  
  var todos: [ToDo] = []
  var sortingType: SortingType = .completed
  var sortingOrder: SortingOrder = .asc
  
}

struct ToDo: Codable {
  fileprivate let id: Int = UUID().hashValue
  var text: String
  var isCompleted: Bool = false
  var date: Date = Date()
  
  init(text: String, isCompleted: Bool = false) {
    self.text = text
    self.isCompleted = isCompleted
  }
  
  mutating func toogleComplete() {
    isCompleted = !isCompleted
  }
}

extension ToDo: Equatable {
  public static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
    return lhs.id == rhs.id
  }
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
