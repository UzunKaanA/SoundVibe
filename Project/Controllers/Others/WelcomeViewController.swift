//
//  WelcomeViewController.swift
//  Project
//
//  Created by Kaan Uzun on 23.01.2024.
//

import UIKit

class WelcomeViewController: UIViewController {

  private let signInButton: UIButton = {
    let button = UIButton()
    button.backgroundColor = .white
    button.setTitle("Sign In with Spotify", for: .normal)
    button.setTitleColor(.blue, for: .normal)
    return button

  }()

  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Spotify"
    view.backgroundColor = .systemGreen
    view.addSubview(signInButton)
    signInButton.addTarget(self, action: #selector(didTapSignIn), for: .touchUpInside)
  }

  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    signInButton.frame = CGRect(x: 20, 
                                y: view.height-50-view.safeAreaInsets.bottom,
                                width: view.width-40,
                                height: 50
                        )
  }

  @objc func didTapSignIn(){
    let vc = AuthViewController()
    vc.completionHandler = { success in
      DispatchQueue.main.async {
        self.handleSignIn(success: success)
      }
    }
    vc.navigationItem.largeTitleDisplayMode = .never
    navigationController?.pushViewController(vc, animated: true)
  }

    //to log user in or give them an error.
  private func handleSignIn(success: Bool){
    guard success else {
      let alert = UIAlertController(title: "Error",
                                    message: "Something went wrong, when signing in!", 
                                    preferredStyle: .alert)
      alert.addAction(UIAlertAction(title: "Dismiss",
                                    style: .cancel,
                                    handler: nil))
      present(alert, animated: true)
      return
    }

    let mainAppTabBarVC = TabBarViewController()
    mainAppTabBarVC.modalPresentationStyle = .fullScreen
    present(mainAppTabBarVC, animated: true)

  }

}
