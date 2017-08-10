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

   

    

    @IBOutlet weak var pollTitleView: UITextView!
    @IBOutlet weak var pollTextView1: UITextView!
    @IBOutlet weak var pollTextView2: UITextView!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
  
    @IBOutlet weak var addPoll: UITabBarItem!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pollTextView1.delegate = self
        pollTextView2.delegate = self
        pollTitleView.delegate = self
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddPollViewController.dismissKeyboard))
        
        view.addGestureRecognizer(tap)
        
        
        
        let color = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0).cgColor
        pollTextView1.layer.borderColor = color
        pollTextView1.layer.borderWidth = 2
        pollTextView1.layer.cornerRadius = 7.5  
        
        let color2 = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0).cgColor
        pollTextView2.layer.borderColor = color2
        pollTextView2.layer.borderWidth = 2
        pollTextView2.layer.cornerRadius = 7.5
        
        cancelButton.layer.cornerRadius = 15
        doneButton.layer.cornerRadius = 15
        pollTitleView.layer.cornerRadius = 7.5
        

        // Do any additional setup after loading the view.
    }
    
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        
        let numberOfChars = newText.characters.count
        
        return numberOfChars < 5
        
    }



    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        self.view.endEditing(true)
        return false
    }

    func textView(pollTextView1: UITextView, pollTextView2: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        if(text == "\n") {
            pollTextView1.resignFirstResponder()
            pollTextView2.resignFirstResponder()
            return false
        }
        return true
    }
    

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        let alertController = UIAlertController(title: "Error", message: "Your have reached the character limit", preferredStyle: UIAlertControllerStyle.alert)
        
        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
        {
            (result : UIAlertAction) -> Void in
        }
        alertController.addAction(okAction)
        
        
        
        if pollTextView1.text.characters.count >= 76
        {
            pollTextView1.endEditing(true)
            pollTextView1.deleteBackward()
            self.present(alertController, animated: true, completion: nil)
            

        }
        
        if pollTextView2.text.characters.count >= 76
        {
            pollTextView2.endEditing(true)
            pollTextView2.deleteBackward()
            self.present(alertController, animated: true, completion: nil)
            

        }
        if pollTitleView.text.characters.count >= 61
        
        {
            pollTitleView.endEditing(true)
            pollTitleView.deleteBackward()
            self.present(alertController, animated: true, completion: nil)
            
            
            
            
        }
        
        return true
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        guard let pollText2 = pollTextView2.text, !pollText2.isEmpty else {
            return
        }
        guard let pollText = pollTextView1.text, !pollText.isEmpty else {
            return
        }
        
        guard let pollTitle = pollTitleView.text, !pollTitle.isEmpty else {
            return
        }
    
        let userAttrs = [ "pollText": pollText, "pollText2": pollText2, "pollTitle": pollTitle]
        let pollAttrs = [ "pollText": pollText, "pollText2": pollText2, "pollTitle": pollTitle, "username": User.current.uid, "uid": User.current.uid, "voteCount": 0, "voteCount2": 0] as [String : Any]

        if(self.pollTextView1.text.characters.count > 60) {
            self.pollTextView1.endEditing(true)
        }
        
        
        
        let ref = Database.database().reference().child("users").child(User.current.uid).child("polls").childByAutoId()
        let pollKey = ref.key
        
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
            }
        }
        
        let newRef = Database.database().reference().child("polls").child(pollKey)
        newRef.setValue(pollAttrs) { (error, ref) in
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
    
}
