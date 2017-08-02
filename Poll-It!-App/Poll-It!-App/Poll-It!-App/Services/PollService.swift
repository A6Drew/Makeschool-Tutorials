//
//  PollService.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-24.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import Foundation
import FirebaseAuth.FIRUser
import FirebaseDatabase

struct PollService {
    
    static func allPolls(for user: User, completion: @escaping ([Poll]) -> Void) {
        
        
        let ref = Database.database().reference().child("polls")
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            
            let polls = snapshot.reversed().flatMap(Poll.init)
            completion(polls)
        }
            
        )}
    }

   
    
