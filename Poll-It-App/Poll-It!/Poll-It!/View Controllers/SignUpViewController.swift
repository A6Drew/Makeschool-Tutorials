
//
//  SignUpViewController.swift
//  Poll-It
//
//  Created by Andrew Ng on 2017-07-20.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseDatabase

class SignUpViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        self.usernameField.delegate = self;
        self.emailField.delegate = self;
        self.passwordField.delegate = self;

        // Do any additional setup after loading the view.
    }
    
    @IBAction func signUpButtonTapped(_ sender: UIButton) {
        guard let username = usernameField.text, !username.isEmpty, let email = emailField.text, !email.isEmpty, let password = passwordField.text, !password.isEmpty else {
            print("User did not enter in fields")
            return
        }
        Auth.auth().createUser(withEmail: emailField.text!, password: passwordField.text!, completion: { (user, error) in
            if error != nil {
                print(error)
                return
            }
            else {
                let userID: String = user!.uid
                let username1: String = self.usernameField.text!
                let email1: String = self.emailField.text!
                let password1: String = self.passwordField.text!
                
                self.ref.child("users").child(userID).setValue(["Username": username1, "Email": email1, "Password": password1])
            }
            
            
        })
        
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        appDelegate.switchViewControllers()
        
        
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    
    @IBAction func unwindToSignUpViewController(_ segue: UIStoryboardSegue) {
        
        // for now, simply defining the method is sufficient.
        // we'll add code later
        
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
