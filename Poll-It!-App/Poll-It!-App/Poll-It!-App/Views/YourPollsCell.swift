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
    
//    let userDefaults: UserDefaults = UserDefaults.standard
    
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
        
        // Update 1.1
//        hidePercent()
//        pollText1Percent.isHidden = (UserDefaults.standard.value(forKey: "labelShouldBeHidden") as? Bool) ?? true
//        pollText2Percent.isHidden = (UserDefaults.standard.value(forKey: "labelShouldBeHidden") as? Bool) ?? true
    }
    
    
    
    var didTapOptionsButtonForCell: ((YourPollsCell) -> Void)?
    

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
        
        let percentColor = UIColor(red: 232/255, green: 75/255, blue: 97/255, alpha: 1.0).cgColor
        pollText1Percent.layer.borderColor = percentColor
        pollText1Percent.layer.borderWidth = 2
        pollText2Percent.layer.borderColor = percentColor
        pollText2Percent.layer.borderWidth = 2
        

       
    }

    func hidePercent() {
//        Update 1.1
//        pollText1Percent.isHidden = true
//        pollText2Percent.isHidden = true
        
//        pollText1Percent.isHidden = (UserDefaults.standard.value(forKey: "labelShouldBeHidden") as? Bool) ?? true
//        pollText2Percent.isHidden = (UserDefaults.standard.value(forKey: "labelShouldBeHidden") as? Bool) ?? true
        
    }
    
    @IBAction func reportButtonTapped(_ sender: UIButton) {
        didTapOptionsButtonForCell?(self)
    }
    
    
    @IBAction func pollText1ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 1, on: self)
        UserDefaults.standard.set(false, forKey: "labelShouldBeHidden")
        
//  Update 1.1
//        pollText1Percent.isHidden = false
//        pollText2Percent.isHidden = false
//

        
        
    }
    
    @IBAction func pollText2ButtonTapped(_ sender: UIButton) {
        
        delegate?.didTapVoteButton(sender, pollNum: 2, on: self)

        UserDefaults.standard.set(false, forKey: "labelShouldBeHidden")
        
// Updata 1.1
//        pollText1Percent.isHidden = false
//        pollText2Percent.isHidden = false

    }
    
 
    
    
}
