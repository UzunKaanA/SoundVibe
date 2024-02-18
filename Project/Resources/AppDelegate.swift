//
//  AppDelegate.swift
//  Project
//
//  Created by Kaan Uzun on 23.01.2024.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let window = UIWindow(frame: UIScreen.main.bounds)

    if AuthManager.shared.isSignedIn{
      AuthManager.shared.refreshIfNeeded(completion: nil)
      window.rootViewController = TabBarViewController()
    }
    else {
      let navVC = UINavigationController(rootViewController: WelcomeViewController())
      navVC.navigationBar.prefersLargeTitles = true
      navVC.viewControllers.first?.navigationItem.largeTitleDisplayMode = .always
      window.rootViewController = navVC
    }
    window.makeKeyAndVisible()
    self.window = window

//    AuthManager.shared.refreshIfNeeded { success in
//    print(success)
//    }

//    print(AuthManager.shared.signInURL?.absoluteString)

    return true
  }


}

