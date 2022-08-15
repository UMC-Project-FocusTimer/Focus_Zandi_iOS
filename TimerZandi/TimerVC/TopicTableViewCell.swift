//
//  TopicTableViewCell.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/08/15.
//

import UIKit

class TopicTableViewCell: UITableViewCell {
    
    
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var topicNameLabel: UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
