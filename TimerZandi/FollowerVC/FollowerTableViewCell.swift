//
//  FollowerTableViewCell.swift
//  TimerZandi
//
//  Created by Jin younkyum on 2022/07/02.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var tapFollwerPage: UIButton!
    @IBOutlet weak var follwerImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
//    @IBOutlet weak var totalTimeLabel: UILabel!
//    @IBOutlet weak var disturbCountLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
