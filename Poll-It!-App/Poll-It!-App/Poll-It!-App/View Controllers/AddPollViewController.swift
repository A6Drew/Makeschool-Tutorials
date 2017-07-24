//
//  AddPollViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-24.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddPollViewController: UIViewController {

   

    

    @IBOutlet weak var pollTextView1: UITextView!
    @IBOutlet weak var pollTextView2: UITextView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    

        
        
    @IBAction func doneButtonTapped(_ sender: UIButton) {
    
    
        if let pollText1 = pollTextView1.text {
            let userAttrs = [ "pollText1": pollText1]
            
            let ref = Database.database().reference().child("users").child(User.current.uid).child("polls").childByAutoId()
            ref.setValue(userAttrs) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                }
                
                
            }
        }
        
        if let pollText2 = pollTextView2.text {
            let userAttrs = [ "pollText2": pollText2]
            
            let ref = Database.database().reference().child("users").child(User.current.uid).child("polls").childByAutoId()
            ref.setValue(userAttrs) { (error, ref) in
                if let error = error {
                    assertionFailure(error.localizedDescription)
                }
                
                
            }
        }
        
    }   

    
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


