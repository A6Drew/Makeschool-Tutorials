//
//  ProfilePollsCell.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-08-02.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

class ProfilePollsCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var profilePollText1: UITextView!

    @IBOutlet weak var profilePollText2: UITextView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
