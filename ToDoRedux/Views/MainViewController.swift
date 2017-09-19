//
//  MainViewController.swift
//  ToDoRedux
//
//  Created by Sarychev Stanislav on 06.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import UIKit
import ReSwift

class MainViewController: UITableViewController, StoreSubscriber {
  
  private var todos: [ToDo] = []
  private let cellIdentifier: String = "todoCell"
  @IBOutlet var tableEmptyView: UIView!
  
  private lazy var addTodoController: UIAlertController = {
    let alertController = UIAlertController(title: "What do You want to do?", message: nil, preferredStyle: .alert)
    alertController.addTextField {
      $0.placeholder = "Enter text here"
    }
    let doneAction = UIAlertAction(title: "Add", style: .default) { _ in
      guard let todoText = alertController.textFields?.first?.text,
        !todoText.isEmpty else { return }
      Redux.store.dispatch(TodoActionCreators.add(todo: ToDo(text: todoText)))
      alertController.textFields?.first?.text = ""
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(doneAction)
    alertController.addAction(cancelAction)
    return alertController
  }()
  
  private lazy var sortController: UIAlertController = {
    let alertController = UIAlertController(title: "How should I sort todos?", message: nil, preferredStyle: .actionSheet)
    let completed = UIAlertAction(title: "Completed", style: .default) { _ in
      Redux.store.dispatch(SortingActions.ChangeSortingType(sortingType: .completed))
    }
    let uncompleted = UIAlertAction(title: "Uncompleted", style: .default) { _ in
      Redux.store.dispatch(SortingActions.ChangeSortingType(sortingType: .uncompleted))
    }
    let date = UIAlertAction(title: "Date", style: .default) { _ in
      Redux.store.dispatch(SortingActions.ChangeSortingType(sortingType: .date))
    }
    let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
    alertController.addAction(completed)
    alertController.addAction(uncompleted)
    alertController.addAction(date)
    alertController.addAction(cancelAction)
    return alertController
  }()
  
  private func showError(with message: String) {
    let alertController = UIAlertController(title: "Error!", message: message, preferredStyle: .alert)
    let cancelAction = UIAlertAction(title: "Ok", style: .cancel)
    alertController.addAction(cancelAction)
    present(alertController, animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.rowHeight = UITableViewAutomaticDimension
    tableView.estimatedRowHeight = 44
    let refreshControl = UIRefreshControl()
    refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    tableView.refreshControl = refreshControl
    Redux.store.dispatch(TodoActionCreators.loadTodos())
  }
  
  func refresh(_ senfer: UIRefreshControl) {
    Redux.store.dispatch(TodoActionCreators.loadTodos())
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    Redux.store.subscribe(self)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    Redux.store.unsubscribe(self)
  }
  
  func newState(state: ApplicationState) {
    if let error = state.todosState.loadingError {
      showError(with: error.localizedDescription)
    } else {
      todos = state.todosState.todos
        .filter { !$0.isArchived }
        .sorted(by: {
          switch state.sortingState.sortingType {
          case .completed:
            return !$0.isCompleted
          case .uncompleted:
            return $0.isCompleted
          case .date:
            return $0.date > $1.date
          }
        })
      DispatchQueue.main.async {
        self.tableView.tableFooterView = self.todos.isEmpty ? self.tableEmptyView : UIView()
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
      }
    }
  }
  
  @IBAction func addToDoButton(_ sender: UIBarButtonItem) {
    present(addTodoController, animated: true)
  }
  
  @IBAction func sortButton(_ sender: UIBarButtonItem) {
    present(sortController, animated: true)
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return todos.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath)
    let todoItem = todos[indexPath.row]
    
    let attributedText = NSMutableAttributedString(string: todoItem.text)
    if todoItem.isCompleted {
      attributedText.addAttribute(NSStrikethroughStyleAttributeName,
                                  value: 2,
                                  range: NSMakeRange(0, attributedText.length))
    }
    cell.textLabel?.attributedText = attributedText
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .medium
    cell.detailTextLabel?.text = dateFormatter.string(from: todoItem.date)
    cell.detailTextLabel?.textColor = todoItem.isCompleted ? .gray : .black
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let selectedTodo = todos[indexPath.row]
    Redux.store.dispatch(TodoActionCreators.toggleCompleted(todo: selectedTodo))
    tableView.deselectRow(at: indexPath, animated: false)
  }
  
  override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    return todos[indexPath.row].isCompleted
  }
  
  override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
    let archiveAction = UITableViewRowAction(style: .normal, title: "Archive") { _ , indexPath in
      let todo = self.todos[indexPath.row]
      Redux.store.dispatch(TodoActionCreators.archive(todo: todo))
    }
    return [archiveAction]
  }
  
  
}

