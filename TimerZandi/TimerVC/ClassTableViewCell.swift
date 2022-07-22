//
//  ClassTableViewCell.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/22.
//

import UIKit

class ClassTableViewCell: UITableViewCell {

        
    @IBOutlet weak var FocusTime: UILabel!
    @IBOutlet weak var className: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
