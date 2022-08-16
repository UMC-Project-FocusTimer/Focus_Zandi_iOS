//
//  ClassTableViewCell.swift
//  TimerZandi
//
//  Created by 이주송 on 2022/07/22.
//

import UIKit

protocol YourCellDelegate : class {
    func didPressButton(_ tag: Int) 
}

class ClassTableViewCell: UITableViewCell {

    
    var cellDelegate: YourCellDelegate?
        @IBOutlet weak var btn: UIButton!
      // connect the button from your cell with this method
      @IBAction func buttonPressed(_ sender: UIButton) {
          cellDelegate?.didPressButton(sender.tag)
      }
        
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
