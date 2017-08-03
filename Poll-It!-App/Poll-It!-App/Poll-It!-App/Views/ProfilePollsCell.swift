//
//  ProfilePollsCell.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-08-02.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

protocol ProfilePollsCellDelegate: class {
    func didTapVoteButton(_polltextButton: UIButton, pollNum: Int, on cell: ProfilePollsCell )
}


class ProfilePollsCell: UITableViewCell {

   weak var delegate: ProfilePollsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    @IBOutlet weak var profilePollText1: UITextView!

    @IBOutlet weak var profilePollText2: UITextView!
    
    @IBOutlet weak var profilePollText1Per: UILabel!
    
    @IBOutlet weak var profilePollText2Per: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func profilePollText1Tapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(_polltextButton: sender, pollNum: 1, on: self)
    }
    
    @IBAction func profilePollText2Tapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(_polltextButton: sender, pollNum: 2, on: self)
        
    }

}
