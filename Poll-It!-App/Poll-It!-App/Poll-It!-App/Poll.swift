//
//  Poll.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-24.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//
//

import Foundation
import Firebase
import FirebaseDatabase.FIRDataSnapshot


class Poll: NSObject {

    var key: String?
    var content: String?
    var content2: String?
    var title: String?
    var voteCount: Int = 0
    var voteCount2: Int = 0
    var votePercent: Double = 0.00
    var votePercent2: Double = 0.00
    var isVoted = [User : Bool]()
    var isVoted2 = [User : Bool]()
//    var isVoted = false
    let poster: User

    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String : Any],
            let pollContent = dict["pollText"] as? String,
            let pollContent2 = dict["pollText2"] as? String,
            let pollTitle = dict["pollTitle"] as? String,
            let username = dict["username"] as? String,
            let uid = dict["uid"] as? String,
            let pollVoteCount = dict["voteCount"] as? Int,
            let pollVoteCount2 = dict["voteCount2"] as? Int
            else { return nil }
        
        self.key = snapshot.key
        self.content = pollContent
        self.content2 = pollContent2
        self.title = pollTitle
        self.poster = User(uid: uid, username: username)
        self.voteCount = pollVoteCount
        self.voteCount2 = pollVoteCount2
        
        if let voteCheck = dict[User.current.uid] as! [String: Any]? {
            if let voteBool = voteCheck["isVoted"] as? Bool {
                self.isVoted = [User.current : voteBool]
            }
            
            if let voteBool2 = voteCheck["isVoted2"] as? Bool {
                self.isVoted2 = [User.current: voteBool2]
            }
        }
    }
    
    init(myPolls: [String: Any], key: String) {
 
        self.key = key
        self.content = myPolls["pollText"] as? String
        self.content2 = myPolls["pollText2"] as? String
        self.title = myPolls["pollTitle"] as? String
        self.voteCount = myPolls["voteCount"] as! Int
        self.voteCount2 = myPolls["voteCount2"] as! Int
        self.poster = User(uid: "", username: myPolls["username"] as! String)
        
        
    }
    

    
    
    
    
}





