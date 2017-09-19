//
//  ToDo.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import Foundation

struct ToDo: Codable {
  let id: Int
  let text: String
  var isCompleted: Bool = false
  var isArchived: Bool = false
  let date: Date
  
  init(text: String) {
    self.id = UUID().hashValue
    self.text = text
    self.isCompleted = false
    self.isArchived = false
    self.date = Date()
  }
  
  mutating func toogleComplete() {
    isCompleted = !isCompleted
  }
  
  mutating func archive() {
    isArchived = true
  }
  
  enum CodingKeys: String, CodingKey {
    case id
    case text
    case isCompleted = "completed"
    case isArchived = "archived"
    case date
  }
}

extension ToDo: Equatable {
  public static func ==(lhs: ToDo, rhs: ToDo) -> Bool {
    return lhs.id == rhs.id
  }
}

extension ToDo: CustomStringConvertible {
  var description: String {
    return "id: \(self.id)\ntext: \(self.text)\ncompleted: \(self.isCompleted)\narchived: \(self.isArchived)\ndate: \(self.date)"
  }
}
