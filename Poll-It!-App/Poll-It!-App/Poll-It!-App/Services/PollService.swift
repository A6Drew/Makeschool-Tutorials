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
    
    static func flag(_ poll: Poll) {

        guard let pollKey = poll.key else { return }

        let flaggedPostRef = Database.database().reference().child("flaggedPosts").child(pollKey)
        
        let flaggedDict = ["pollText1": poll.content,
                           "pollText2": poll.content2,
                           "pollTitle": poll.title,
                           "poster_uid": poll.poster.uid,
                           "reporter_uid": User.current.uid]

        flaggedPostRef.updateChildValues(flaggedDict)
        
        let flagCountRef = flaggedPostRef.child("flag_count")
        flagCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
            let currentCount = mutableData.value as? Int ?? 0
            
            mutableData.value = currentCount + 1
            
            return TransactionResult.success(withValue: mutableData)
        })
    }
}


   
    
