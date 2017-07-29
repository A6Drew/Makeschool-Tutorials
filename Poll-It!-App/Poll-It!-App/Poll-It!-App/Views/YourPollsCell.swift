//
//  YourPollsCell.swift
//  Poll-It!-App
//
//  Created by Andrew Ng on 2017-07-25.
//  Copyright © 2017 Andrew Ng. All rights reserved.
//

import UIKit

protocol YourPollsCellDelegate: class {
    
    func didTapVoteButton(_ pollTextButton: UIButton, pollNum: Int, on cell: YourPollsCell)
    
}

class YourPollsCell: UITableViewCell {
    
    weak var delegate: YourPollsCellDelegate?

    @IBOutlet weak var pollUsername: UILabel!
    @IBOutlet weak var pollText1Button: UIButton!
    @IBOutlet weak var pollText2Button: UIButton!

  
    @IBOutlet weak var pollText1View: UITextView!
    @IBOutlet weak var pollText2View: UITextView!
    @IBOutlet weak var pollText1Percent: UILabel!
    @IBOutlet weak var pollText2Percent: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func pollText1ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 1, on: self)
        
    }
    
    @IBAction func pollText2ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 2, on: self)
    }
    
    
}
