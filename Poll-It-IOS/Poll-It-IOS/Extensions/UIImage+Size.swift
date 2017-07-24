//
//  UIImage+Size.swift
//  Poll-It-IOS
//
//  Created by Andrew Ng on 2017-07-21.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

extension UIImage {
    var aspectHeight: CGFloat {
        let heightRatio = size.height / 736
        let widthRatio = size.width / 414
        let aspectRatio = fmax(heightRatio, widthRatio)
        
        return size.height / aspectRatio
    }
}
