//
//  SettingsViewController.swift
//  ToDoRedux
//
//  Created by Станислав Сарычев on 18.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import UIKit
import ReSwift

class SettingsViewController: UITableViewController, StoreSubscriber {
  
  @IBOutlet weak var postSwitch: UISwitch!
  
  @IBAction func closeAction(_ sender: UIBarButtonItem) {
    self.dismiss(animated: true, completion: nil)
  }
  
  @IBAction func postSwitchAction(_ sender: UISwitch) {
    Redux.store.dispatch(SynchronizationActions.SynchronizeNewTodos())
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
    postSwitch.isOn = state.synchronizationState.synchronizeNewTodos
  }

}
