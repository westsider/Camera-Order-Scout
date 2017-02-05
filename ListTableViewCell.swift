//
//  ListTableViewCell.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

class ListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var imageTableViewCell: UIImageView!
    
    @IBOutlet weak var titleTableView: UILabel!
    
    @IBOutlet weak var detailTableView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
