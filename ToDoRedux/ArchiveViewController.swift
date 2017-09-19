//
//  ArchiveViewController.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 18.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import UIKit
import ReSwift

class ArchiveViewController: UITableViewController, StoreSubscriber {
  
  private var archivedTodos: [ToDo] = []
  @IBOutlet var tableEmptyView: UIView!
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Redux.store.subscribe(self)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    Redux.store.unsubscribe(self)
  }
  
  func newState(state: ApplicationState) {
    archivedTodos = state.todosState.todos.filter { $0.isArchived }
    DispatchQueue.main.async {
      self.tableView.tableFooterView = self.archivedTodos.isEmpty ? self.tableEmptyView : UIView()
      self.tableView.reloadData()
    }
  }
  
  // MARK: - Table view data source
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return archivedTodos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "archiveTodoCell", for: indexPath)
    let todo = archivedTodos[indexPath.row]
    cell.textLabel?.text = todo.text
    return cell
  }
  
  // MARK: - Table view delegate
  override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
    switch editingStyle {
    case .delete:
      let todo = archivedTodos[indexPath.row]
      Redux.store.dispatch(TodoActionCreators.delete(todo: todo))
    default: break
    }
  }
  
}
