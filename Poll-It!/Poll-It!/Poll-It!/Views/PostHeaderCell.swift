//
//  PostHeaderCell.swift
//  Makestagram
//
//  Created by Andrew Ng on 2017-07-17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit

class PostHeaderCell: UITableViewCell {
    
    static let height: CGFloat = 54
    
    @IBOutlet weak var usernameLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    @IBAction func optionsButtonTapped(_ sender: UIButton) {
    }
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
