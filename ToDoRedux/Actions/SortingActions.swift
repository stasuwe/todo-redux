//
//  SortingActions.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum SortingActions {
  struct ChangeSortingType: Action {
    let sortingType: SortingType
  }
  
  struct ChangeSortingOrder: Action {
    let sortingOrder: SortingOrder
  }
}
