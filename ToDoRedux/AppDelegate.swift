//
//  AppDelegate.swift
//  ToDoRedux
//
//  Created by Sarychev Stanislav on 06.09.17.
//  Copyright © 2017 LLC «Globus Media». All rights reserved.
//

import UIKit
import ReSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    fileprivate let applicationStore = Store(reducer: ApplicationReducer.reducer,
                                             state: ApplicationState(),
                                             middleware: [Middlewares.logging])
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }
}

extension AppDelegate: StoreHolder {
    var store: Store<ApplicationState> {
        return applicationStore
    }
}



