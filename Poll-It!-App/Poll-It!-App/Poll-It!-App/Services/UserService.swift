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
    
    static func polls(for user: User, completion: @escaping ([Poll]) -> Void) {
        let ref = Database.database().reference().child("users").child(user.uid).child("polls")
        let pollKey = ref.key
        let ref2 = Database.database().reference().child("polls").child(pollKey)
        
        ref.observeSingleEvent(of: .value, with: { (snapshot) in
            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
                return completion([])
            }
            ref2.observeSingleEvent(of: .value, with: { (snapshot) in
                guard let snapshot2 = snapshot.children.allObjects as? [DataSnapshot] else {
                    return completion([])
                }
//                for 
//                if snapshot.key == snapshot2.key {
//                
//                let polls = snapshot.reversed().flatMap(Poll.init)
//                completion(polls)
//                }
            })
            
            
        }
   )}
//
//    static func polls(for user: User, completion: @escaping ([Poll]) -> Void) {
//        let ref = Database.database().reference().child("polls").child(user.uid)
//        ref.observeSingleEvent(of: .value, with: { (snapshot) in
//            guard let snapshot = snapshot.children.allObjects as? [DataSnapshot] else {
//                return completion([])
//            }
//            
//            let dispatchGroup = DispatchGroup()
//            
//            let polls: [Poll] =
//                snapshot
//                    .reversed()
//                    .flatMap {
//                        guard let poll = Poll(snapshot: $0)
//                            else { return nil }
//                        
//                        dispatchGroup.enter()
//                        
//                        VoteService.isPollVoted(poll) { (isVoted) in
//                            poll.isVoted = isVoted
//                            
//                            dispatchGroup.leave()
//                        }
//                        
//                        return poll
//            }
//            
//            dispatchGroup.notify(queue: .main, execute: {
//                completion(polls)
//            })
//        })
//    }
}
