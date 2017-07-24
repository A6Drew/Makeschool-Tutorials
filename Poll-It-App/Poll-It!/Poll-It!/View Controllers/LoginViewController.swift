//
//  LoginViewController.swift
//  Poll-It
//
//  Created by Andrew Ng on 2017-07-20.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth

class LoginViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var emailLogin: UITextField!
    @IBOutlet weak var passwordLogin: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.emailLogin.delegate = self;
        self.passwordLogin.delegate = self;

        // Do any additional setup after loading the view.
    }
    
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        guard let email1 = emailLogin.text, !email1.isEmpty, let password1 = passwordLogin.text, !password1.isEmpty
            else {
                print("User did not enter in fields")
                return
        }
        Auth.auth().signIn(withEmail: emailLogin.text!, password: passwordLogin.text!, completion: { (user, error) in
            if error != nil {
                print("Error signing in")
                return
            }
        })
        
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        let initialViewController = storyboard.instantiateInitialViewController()
        self.view.window?.rootViewController = initialViewController
        self.view.window?.makeKeyAndVisible()
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
