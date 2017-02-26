//
//  AKSTableViewCell.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/26/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class AKSTableViewCell: UITableViewCell {

    @IBOutlet weak var aksLabel: UILabel!
    
    @IBOutlet weak var aksSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    @IBAction func switchValueChanged(_ sender: Any) {
    }

}


//@IBOutlet weak var lensSwitch: UISwitch!
//
//@IBOutlet weak var lensLabel: UILabel!
//
//override func awakeFromNib() {
//    super.awakeFromNib()
//    // Initialization code
//}
//
//override func setSelected(_ selected: Bool, animated: Bool) {
//    super.setSelected(selected, animated: animated)
//    
//    // Configure the view for the selected state
//}
//
//@IBAction func switchValueChanged(_ sender: Any) {
//}
