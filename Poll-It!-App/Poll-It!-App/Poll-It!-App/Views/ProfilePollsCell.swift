//
//  ProfilePollsCell.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-08-02.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

protocol ProfilePollsCellDelegate: class {
    func didTapVoteButton(_profileTextButton: UIButton, pollNum: Int, on cell: ProfilePollsCell )
}


class ProfilePollsCell: UITableViewCell {

   weak var delegate: ProfilePollsCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        
    }
    
    
    
    @IBOutlet weak var profilePollTitle: UITextView!
    
    @IBOutlet weak var profilePollText1: UITextView!

    @IBOutlet weak var profilePollText2: UITextView!
    
    @IBOutlet weak var profilePollText1Per: UILabel!
    
    @IBOutlet weak var profilePollText2Per: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        let percentColor = UIColor(red: 232/255, green: 75/255, blue: 97/255, alpha: 1.0).cgColor
        profilePollText1Per.layer.borderColor = percentColor
        profilePollText1Per.layer.borderWidth = 2
        profilePollText2Per.layer.borderColor = percentColor
        profilePollText2Per.layer.borderWidth = 2
    }
    
    @IBAction func profilePollText1Tapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(_profileTextButton: sender, pollNum: 1, on: self)
    }
    
    @IBAction func profilePollText2Tapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(_profileTextButton: sender, pollNum: 2, on: self)
        
    }

}
