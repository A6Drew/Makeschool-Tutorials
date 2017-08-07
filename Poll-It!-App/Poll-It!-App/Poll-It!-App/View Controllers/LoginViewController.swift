//
//  LoginViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-23.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseAuthUI
import FirebaseDatabase


typealias FIRUser = FirebaseAuth.User

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var loginButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        print("Login Button Tapped")
        // 1
        guard let authUI = FUIAuth.defaultAuthUI()
            else { return }
        
        // 2
        authUI.delegate = self
        
        // 3
        let authViewController = authUI.authViewController()
        
        let userDefault = UserDefaults.standard
        userDefault.set(true, forKey: "loggedIn")
        userDefault.synchronize()
        
        present(authViewController, animated: true)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    
}

extension LoginViewController: FUIAuthDelegate {
    func authUI(_ authUI: FUIAuth, didSignInWith user: FIRUser?, error: Error?) {
        if let error = error {
            print("Error signing in \(error.localizedDescription)")
            return
        }
        // 1
        guard let user = user
            else {return}
        
        // 2
        let userRef = Database.database().reference().child("users").child(user.uid)
        
        //3
        userRef.observeSingleEvent(of: .value, with: { [unowned self] (snapshot) in
            UserService.show(forUID: user.uid) { (user) in
                if let user = user {
                    // handle existing user
                    User.setCurrent(user, writeToUserDefaults: true)
                    
                    let initialViewController = UIStoryboard.initialViewController(for: .main)
                    self.view.window?.rootViewController = initialViewController
                    self.view.window?.makeKeyAndVisible()
                } else {
                    // handle new user
                    self.performSegue(withIdentifier: Constants.Segue.toCreateUsername, sender: self)
                }
            }
        })
        print("handle user signup / login")
    }
}
