//
//  AppDelegate.swift
//  QuizApp
//
//  Created by Abdoulaye Diallo on 1/15/21.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


     var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewController = QuestionViewController(question: "A question?", options: ["Options1", "Options2"]){
            print($0)
        }
        _ = viewController.view
        
        viewController.tableView.allowsMultipleSelection  = false
        window.rootViewController = viewController
        self.window = window
        
        window.makeKeyAndVisible()
        
        return true
    }
}

