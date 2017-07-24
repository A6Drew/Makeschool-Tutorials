//
//  Post.swift
//  Poll-It-IOS
//
//  Created by Andrew Ng on 2017-07-21.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit
import FirebaseDatabase.FIRDataSnapshot

class Post {
        var key: String?
        let imageURL: String
        let imageHeight: CGFloat
        let creationDate: Date
    
    init(imageURL: String, imageHeight: CGFloat) {
        self.imageURL = imageURL
        self.imageHeight = imageHeight
        self.creationDate = Date()
    }
    
//     private static func create(forURLString urlString: String, aspectHeight: CGFloat) {
//        // 1
//        let currentUser = User.current
//        // 2
//        let post = Post(imageURL: urlString, imageHeight: aspectHeight)
//        // 3
//        let dict = post.dictValue
//        
//        // 4
//        let postRef = Database.database().reference().child("posts").child(currentUser.uid).childByAutoId()
//        //5
//        postRef.updateChildValues(dict)
//    }
    
    
    var dictValue: [String : Any] {
        let createdAgo = creationDate.timeIntervalSince1970
        
        return ["image_url" : imageURL,
                "image_height" : imageHeight,
                "created_at" : createdAgo]
    }
    
    
}





    
