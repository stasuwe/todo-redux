//
//  Middleware.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 18.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum Middlewares {
  
  static let logging: Middleware<ApplicationState> = { dispatch, getState in
    return { next in
      return { action in
        print(action)
        return next(action)
      }
    }
  }
  
}
