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
    @IBOutlet weak var pollText1View: UITextView!
    @IBOutlet weak var pollText2View: UITextView!
    @IBOutlet weak var pollText1Button: UIButton!
    @IBOutlet weak var pollText2Button: UIButton!

    @IBOutlet weak var pollText1Percent: UILabel!
    @IBOutlet weak var pollText2Percent: UILabel!
    
    @IBOutlet weak var background: UIView!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hidePercent()
    }
    
    
    
    var didTapOptionsButtonForCell: ((YourPollsCell) -> Void)?
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        let percentColor = UIColor(red: 115/255, green: 21/255, blue: 54/255, alpha: 1.0).cgColor
        pollText1Percent.layer.borderColor = percentColor
        pollText1Percent.layer.borderWidth = 2
        pollText2Percent.layer.borderColor = percentColor
        pollText2Percent.layer.borderWidth = 2
        
//       let width = UIScreen.main.bounds.width
//       let height = UIScreen.main.bounds.height
//        
//        let widthConstraint = NSLayoutConstraint(item: pollText1View,
//            attribute: .width,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .notAnAttribute,
//            multiplier: 1.0, constant: width/10)
//        
//        let heightConstraint = NSLayoutConstraint(item: pollText1View,
//            attribute: .height,
//            relatedBy: .equal,
//            toItem: nil,
//            attribute: .notAnAttribute,
//            multiplier: 1.0, constant: height/10)
        
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

//pollText1Percent.isHidden = true
//pollText2Percent.isHidden = true
       
    }

    func hidePercent() {
        pollText1Percent.isHidden = true
        pollText2Percent.isHidden = true
    }
    
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        didTapOptionsButtonForCell?(self)
    }
    
    
    @IBAction func pollText1ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 1, on: self)
//        pollText1Percent.isHidden = !pollText1Percent.isHidden
//        pollText2Percent.isHidden = !pollText2Percent.isHidden
        pollText1Percent.isHidden = false
        pollText2Percent.isHidden = false
      

//        pollText1View.backgroundColor = UIColor(red: 232/255, green: 75/255, blue: 97/255, alpha: 1)
//        pollText1Button.backgroundColor = UIColor(red: 127/255, green: 41/255, blue: 53/255, alpha: 1)
        //pollText1Button.isEnabled = false
        
        
    }
    
    @IBAction func pollText2ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 2, on: self)
//        pollText1Percent.isHidden = !pollText1Percent.isHidden
//        pollText2Percent.isHidden = !pollText2Percent.isHidden
//        pollText2View.backgroundColor = UIColor(red: 232/255, green: 75/255, blue: 97/255, alpha: 1)
//        pollText2Button.backgroundColor = UIColor(red: 127/255, green: 41/255, blue: 53/255, alpha: 1)
        //pollText2Button.isEnabled = false
        
        pollText1Percent.isHidden = false
        pollText2Percent.isHidden = false

    }
    
 
    
    
}
