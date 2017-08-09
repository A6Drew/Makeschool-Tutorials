//
//  UserService.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-23.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct UserService {
    
    static func show(forUID uid: String, completion: @escaping (User?) -> Void) {
        let ref = Database.database().reference().child("users").child(uid)
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let user = User(snapshot: snapshot) else {
                return completion(nil)
            }
            
            completion(user)
        })
    }
    
    
    static func create(_ firUser: FIRUser, username: String, completion: @escaping (User?) -> Void) {
        let userAttrs = ["username": username]
        
        let ref = Database.database().reference().child("users").child(firUser.uid)
        ref.setValue(userAttrs) { (error, ref) in
            if let error = error {
                assertionFailure(error.localizedDescription)
                return completion(nil)
            }
            
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                let user = User(snapshot: snapshot)
                completion(user)
            })
        }
    }
    
    static func polls(completion: @escaping ([Poll]) -> Void) {
        let ref = Database.database().reference().child("users").child(User.current.uid).child("polls")
        let ref2 = Database.database().reference().child("polls")
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot1 = snapshot.value as? [String: Any] else {
                return completion([])
            }
            
            ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let snapshot2 = snapshot.value as? [String: Any] else {
                    return completion([])
                }
                var myPolls = [Poll]()

                for key1 in snapshot1.keys {
                    
                    for key2 in snapshot2.keys {
                        
                        if key1 == key2 {                     
                            myPolls.append(Poll(myPolls: (snapshot2[key2] as! [String: Any]), key: key2))
                        }
                    }
                }
                
                
                return completion(myPolls)

            })
        }
   )}
}
