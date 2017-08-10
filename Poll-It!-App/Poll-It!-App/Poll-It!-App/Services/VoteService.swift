//
//  VoteService.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-26.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import Foundation
import FirebaseDatabase

struct VoteService {
    
    
    
    static func voting(for user: User, poll: Poll) {
        
        let ref = Database.database().reference().child("polls").child(poll.key!)
        let voteAttrs = ["voteCount": poll.voteCount, "voteCount2": poll.voteCount2]
        ref.updateChildValues(voteAttrs)
        
        let voteAttrs2 = ["isVoted": poll.isVoted[user], "isVoted2": poll.isVoted2[user]]
        ref.child("voted users").child(user.uid).updateChildValues(voteAttrs2)
    
    }
    
    
}
    



