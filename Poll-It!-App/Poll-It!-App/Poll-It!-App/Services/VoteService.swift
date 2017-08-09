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
    
//    static func create(for poll: Poll, success: @escaping (Bool) -> Void) {
//        
//        let votesRef = Database.database().reference().child("polls").childByAutoId().child(User.current.uid)
//        votesRef.setValue(true) { (error, _)  in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return success(false)
//            }
//            
//            let voteCountRef = Database.database().reference().child(User.current.uid).child("polls").childByAutoId().child("vote_count")
//            voteCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
//                let currentCount = mutableData.value as? Int ?? 0
//                
//                mutableData.value = currentCount + 1
//                
//                return TransactionResult.success(withValue: mutableData)
//            }, andCompletionBlock: { (error, _, _) in
//                if let error = error {
//                    assertionFailure(error.localizedDescription)
//                    success(false)
//                } else {
//                    success(true)
//                }
//            })
//        }
//    }
//    
//    static func delete(for poll: Poll, success: @escaping (Bool) -> Void) {
//
//        
//        let votesRef = Database.database().reference().child("pollVotes").childByAutoId().child(User.current.uid)
//        votesRef.setValue(nil) { (error, _) in
//            if let error = error {
//                assertionFailure(error.localizedDescription)
//                return success(false)
//            }
//            
//            let voteCountRef =
//                Database.database().reference().child(User.current.uid).child("pollVotes").childByAutoId().child("vote_count")
//            voteCountRef.runTransactionBlock({ (mutableData) -> TransactionResult in
//                let currentCount = mutableData.value as? Int ?? 0
//                
//                mutableData.value = currentCount - 1
//                
//                return TransactionResult.success(withValue: mutableData)
//            }, andCompletionBlock: { (error, _, _) in
//                if let error = error {
//                    assertionFailure(error.localizedDescription)
//                    success(false)
//                } else {
//                    success(true)
//                }
//            })
//        }
//    }
//    
//    static func isPollVoted(_ poll: Poll, byCurrentUserWithCompletion completion: @escaping (Bool) -> Void) {
//        guard let pollKey = poll.key else {
//            assertionFailure("Error: post must have key.")
//            return completion(false)
//        }
//        
//        let votesRef = Database.database().reference().child("pollVotes").childByAutoId()
//        votesRef.queryEqual(toValue: nil, childKey: User.current.uid).observeSingleEvent(of: .value, with: { (snapshot) in
//            if let _ = snapshot.value as? [String : Bool] {
//                completion(true)
//            } else {
//                completion(false)
//            }
//        })
//    }
//    
//    static func setIsVoted(_ isVoted: Bool, for poll: Poll, success: @escaping (Bool) -> Void) {
//        if isVoted {
//            create(for: poll, success: success)
//        } else {
//            delete(for: poll, success: success)
//        }
//    }


