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

class YourPollsCell: UITableViewCell, UITextFieldDelegate {
    
    weak var delegate: YourPollsCellDelegate?

    

    @IBOutlet weak var pollTitle: UITextView!
    @IBOutlet weak var pollText1Button: UIButton!
    @IBOutlet weak var pollText2Button: UIButton!
    @IBOutlet weak var pollText1View: UITextView!
    @IBOutlet weak var pollText2View: UITextView!
    @IBOutlet weak var pollText1Percent: UILabel!
    @IBOutlet weak var pollText2Percent: UILabel!
    
    @IBOutlet weak var background: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        let percentColor = UIColor(red: 115/255, green: 21/255, blue: 54/255, alpha: 1.0).cgColor
        pollText1Percent.layer.borderColor = percentColor
        pollText1Percent.layer.borderWidth = 2
        pollText2Percent.layer.borderColor = percentColor
        pollText2Percent.layer.borderWidth = 2
        
     
        
//        let pollColor = UIColor(red: 240/255, green: 248/255, blue: 242/255, alpha: 1.0).cgColor
//        pollText1View.layer.borderColor = pollColor
//        pollText1View.layer.borderWidth = 2
//        pollText2View.layer.borderColor = pollColor
//        pollText2View.layer.borderWidth = 2
        
        
//        let color = UIColor(red: 0/255, green: 205/255, blue: 205/255, alpha: 1.0).cgColor
//        pollText1View.layer.borderColor = color
//        pollText1View.layer.borderWidth = 2
//
//        
//        let color2 = UIColor(red: 0/255, green: 205/255, blue: 205/255, alpha: 1.0).cgColor
//        pollText2View.layer.borderColor = color2
//        pollText2View.layer.borderWidth = 2


    }
    
    
    @IBAction func pollText1ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 1, on: self)
        //pollText2Button.isEnabled = false
        
    }
    
    @IBAction func pollText2ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 2, on: self)
        //pollText1Button.isEnabled = false
    }
    

    
    
}
