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

struct ToDo {
    let text: String
    var isCompleted: Bool = false
    let date: Date = Date()
    
    init(text: String, isCompleted: Bool = false) {
        self.text = text
        self.isCompleted = isCompleted
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
