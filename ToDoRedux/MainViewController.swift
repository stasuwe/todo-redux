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
    
    private lazy var addTodoController: UIAlertController = {
       let alertController = UIAlertController(title: "What should You do?", message: nil, preferredStyle: .alert)
        alertController.addTextField {
            $0.placeholder = "Enter text here"
        }
        let doneAction = UIAlertAction(title: "Add", style: .default) { _ in
            guard let todoText = alertController.textFields?.first?.text,
                !todoText.isEmpty else { return }
            Redux.store.dispatch(AddAction(todo: ToDo(text: todoText)))
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
            Redux.store.dispatch(ChangeSortAction(sortingType: .completed))
        }
        let uncompleted = UIAlertAction(title: "Uncompleted", style: .default) { _ in
            Redux.store.dispatch(ChangeSortAction(sortingType: .uncompleted))
        }
        let date = UIAlertAction(title: "Date", style: .default) { _ in
            Redux.store.dispatch(ChangeSortAction(sortingType: .date))
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(completed)
        alertController.addAction(uncompleted)
        alertController.addAction(date)
        alertController.addAction(cancelAction)
        return alertController
    }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        Redux.store.subscribe(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        Redux.store.unsubscribe(self)
    }
    
    func newState(state: ApplicationState) {
        todos = state.todos.sorted(by: {
            switch state.sortingType {
            case .completed:
                return $0.isCompleted == $1.isCompleted
            case .uncompleted:
                return $0.isCompleted != $1.isCompleted
            case .date:
                return $0.date > $1.date
            }
        })
        tableView.reloadData()
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
        cell.textLabel?.text = todoItem.text
        cell.detailTextLabel?.text = todoItem.date.description
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }

}

