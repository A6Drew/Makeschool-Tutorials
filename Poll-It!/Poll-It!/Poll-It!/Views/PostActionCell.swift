//
//  PostActionCell.swift
//  Makestagram
//
//  Created by Andrew Ng on 2017-07-17.
//  Copyright © 2017 Make School. All rights reserved.
//

import UIKit


protocol PostActionCellDelegate: class {
    func didTapLikeButton(_ likeButton: UIButton, on cell: PostActionCell)
}


class PostActionCell: UITableViewCell {

    
    weak var delegate: PostActionCellDelegate?

    
    static let height: CGFloat = 46
    
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeButtonCount: UILabel!
    @IBOutlet weak var timeAgoLabel: UILabel!
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    @IBAction func likeButtonTapped(_ sender: UIButton) {
        delegate?.didTapLikeButton(sender, on: self)
    }
//
//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
