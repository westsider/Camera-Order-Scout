//
//  primeLensTableViewCell.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import UIKit

class primeLensTableViewCell: UITableViewCell {

    @IBOutlet weak var lensSwitch: UISwitch!
    
    @IBOutlet weak var lensLabel: UILabel!
    
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
