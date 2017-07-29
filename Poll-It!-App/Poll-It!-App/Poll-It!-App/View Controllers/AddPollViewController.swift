//
//  AddPollViewController.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-24.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import FirebaseDatabase

class AddPollViewController: UIViewController, UITextViewDelegate {

   

    

    @IBOutlet weak var pollTextView1: UITextView!
    @IBOutlet weak var pollTextView2: UITextView!
  
    @IBOutlet weak var addPoll: UITabBarItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddPollViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        pollTextView1.delegate = self
        pollTextView2.delegate = self
        
        let color = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        pollTextView1.layer.borderColor = color
        pollTextView1.layer.borderWidth = 2
        pollTextView1.layer.cornerRadius = 5
        
        let color2 = UIColor(red: 186/255, green: 186/255, blue: 186/255, alpha: 1.0).cgColor
        pollTextView2.layer.borderColor = color2
        pollTextView2.layer.borderWidth = 2
        pollTextView2.layer.cornerRadius = 5
        
        

        // Do any additional setup after loading the view.
    }
    
    
    
    
//    func textViewShouldReturn(_ textView: UITextView) -> Bool {
//        self.view.endEditing(true)
//        return false
//    }

//    func textView(pollTextView1: UITextView, pollTextView2: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
//        if(text == "\n") {
//            pollTextView1.resignFirstResponder()
//            pollTextView2.resignFirstResponder()
//            return false
//        }
//        return true
//    }
    

        
        
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let pollText2 = pollTextView2.text, !pollText2.isEmpty else {
            return
        }
        guard let pollText = pollTextView1.text, !pollText.isEmpty else {
            return
        }
    
        let userAttrs = [ "pollText": pollText, "pollText2": pollText2]
        
        
        let ref = Database.database().reference().child("users").child(User.current.uid).child("polls").childByAutoId()
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @IBAction func cancelButtonTapped(_ sender: UIButton) {
        
        self.dismiss(animated: true, completion: nil)
        
    }

    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool
    {
        if(text == "\n")
        {
            view.endEditing(true)
            return false
        }
        else
        {
            return true
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


