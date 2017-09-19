//
//  TodoActionCreators.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 19.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import ReSwift

enum TodoActionCreators {
  
  static func loadTodos() -> Store<ApplicationState>.ActionCreator {
    return { state, store in
      let url = URL(string: "http://localhost:3000/todos")
      URLSession.shared.dataTask(with: url!) { data, response, error in
        if let error = error {
          DispatchQueue.main.async {
            store.dispatch(TodoActions.LoadingError(error: error))
          }
        } else {
          do {
            let todos = try JSONDecoder().decode([ToDo].self, from: data!)
            DispatchQueue.main.async {
              store.dispatch(TodoActions.Load(todos: todos))
            }
          } catch {
            DispatchQueue.main.async {
              store.dispatch(TodoActions.LoadingError(error: error))
            }
          }
        }
        }.resume()
      return nil
    }
  }
  
  static func add(todo: ToDo) -> Store<ApplicationState>.ActionCreator {
    return { state, store in
      if state.synchronizationState.synchronizeNewTodos {
        let url = URL(string: "http://localhost:3000/todos")
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(todo)
        URLSession.shared.dataTask(with: request) { _, response, error in
          if let error = error {
            print(error.localizedDescription)
          }
          DispatchQueue.main.async {
            store.dispatch(TodoActions.Add(todo: todo))
          }
          }.resume()
        return nil
      }
      return TodoActions.Add(todo: todo)
    }
  }
  
  static func archive(todo: ToDo) -> Store<ApplicationState>.ActionCreator {
    return { state, store in
      var mutableTodo = todo
      let url = URL(string: "http://localhost:3000/todos/\(mutableTodo.id)")
      var request = URLRequest(url: url!)
      request.httpMethod = "PUT"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      mutableTodo.isArchived = true
      request.httpBody = try? JSONEncoder().encode(mutableTodo)
      URLSession.shared.dataTask(with: request) { _, response, error in
        if let error = error {
          print(error.localizedDescription)
        }
        DispatchQueue.main.async {
          store.dispatch(TodoActions.Archive(todo: todo))
        }
        }.resume()
      return nil
    }
  }
  
  static func delete(todo: ToDo) -> Store<ApplicationState>.ActionCreator {
    return { state, store in
      let url = URL(string: "http://localhost:3000/todos/\(todo.id)")
      var request = URLRequest(url: url!)
      request.httpMethod = "DELETE"
      URLSession.shared.dataTask(with: request) { _, response, error in
        if let error = error {
          print(error.localizedDescription)
        }
        DispatchQueue.main.async {
          store.dispatch(TodoActions.Delete(todo: todo))
        }
        }.resume()
      return nil
    }
  }
  
  static func toggleCompleted(todo: ToDo) -> Store<ApplicationState>.ActionCreator {
    return { state, store in
      var mutableTodo = todo
      let url = URL(string: "http://localhost:3000/todos/\(mutableTodo.id)")
      var request = URLRequest(url: url!)
      request.httpMethod = "PUT"
      request.addValue("application/json", forHTTPHeaderField: "Content-Type")
      mutableTodo.isCompleted = !todo.isCompleted
      request.httpBody = try? JSONEncoder().encode(mutableTodo)
      URLSession.shared.dataTask(with: request) { _, response, error in
        if let error = error {
          print(error.localizedDescription)
        }
        DispatchQueue.main.async {
          store.dispatch(TodoActions.ToggleCompleted(todo: todo))
        }
        }.resume()
      return nil
    }
  }
}
