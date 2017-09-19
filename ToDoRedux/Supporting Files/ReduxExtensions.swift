//
//  ReduxExtensions.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

protocol StoreHolder {
  var store: Store<ApplicationState> { get }
}

enum Redux {
  static let store: Store<ApplicationState> = (UIApplication.shared.delegate as! StoreHolder).store
}
