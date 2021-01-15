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
        window?.rootViewController = UIViewController(nibName: "QuestionViewController", bundle: nil) 
        window?.makeKeyAndVisible()
        return true
    }
}

