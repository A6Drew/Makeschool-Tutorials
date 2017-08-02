//
//  ProfileViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-26.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth 

class ProfileViewController: UIViewController {


    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var signOutButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    

 
    
    @IBAction func signOutButtonTapped(_ sender: UIButton) {
    
        try! Firebase.Auth.auth().signOut()
        
        let vc = UIStoryboard(name: "Login", bundle: nil).instantiateViewController(withIdentifier: "first") as? FirstViewController
        self.show(vc!, sender: self)
        
        let userDefault = UserDefaults.standard
        userDefault.set(false, forKey: "loggedIn")
        userDefault.synchronize()
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


