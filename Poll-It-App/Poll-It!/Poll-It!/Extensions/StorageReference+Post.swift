//
//  StorageReference+Post.swift
//  Poll-It-IOS
//
//  Created by Andrew Ng on 2017-07-21.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import Foundation
import FirebaseStorage

extension StorageReference {
    static let dateFormatter = ISO8601DateFormatter()
    
    static func newPostImageReference() -> StorageReference {
        let uid = User.current.uid
        let timestamp = dateFormatter.string(from: Date())
        
        return Storage.storage().reference().child("images/posts/\(uid)/\(timestamp).jpg")
    }
}
