//
//  CreateUsernameViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-23.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseDatabase

class CreateUsernameViewController: UIViewController, UITextFieldDelegate {
    
   
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var doneButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CreateUsernameViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
        
        usernameTextField.delegate = self
    }
    
    

    
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let firUser = Auth.auth().currentUser,
            let username = usernameTextField.text,
            !username.isEmpty else { return }
        

        let alertController = UIAlertController(title: "Error", message: "Your have reached the character limit", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        
        let dispatchGroup = DispatchGroup()
        
        
        let checkRef = Database.database().reference().child("users")
        
        dispatchGroup.enter()
        
        checkRef.observeSingleEvent(of: .value, with: { (snapshot) in
            let snap = snapshot.value as? [String: Any]
            
            for value in (snap?.values)! {
                let userDictionary = value as? [String: String]
                if let username = userDictionary?["username"] {
                    if username == self.usernameTextField.text {
                        self.present(alertController, animated: true, completion: nil)
                        return
                    }
                }
            }
            dispatchGroup.leave()
        })

        
        dispatchGroup.notify(queue: .main) { 
            UserService.create(firUser, username: username) { (user) in
                guard let user = user else {
                    // handle error
                    return
                }
                
                User.setCurrent(user, writeToUserDefaults: true)
                
                let initialViewController = UIStoryboard.initialViewController(for: .main)
                self.view.window?.rootViewController = initialViewController
                self.view.window?.makeKeyAndVisible()
            }
            let userAttrs = ["username": username]
            
            let ref = Database.database().reference().child("users").child(firUser.uid)
            
            ref.setValue(userAttrs) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                    
                    return
                }
                
                ref.observeSingleEvent(of: .value, with: { (snapshot) in
                    let user = User(snapshot: snapshot)
                })
                
            }
        }
        
        dismissKeyboard()
    
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool // called when 'return' key pressed. return NO to ignore.
    {
        textField.resignFirstResponder()
        return true;
    }
    
    
}
