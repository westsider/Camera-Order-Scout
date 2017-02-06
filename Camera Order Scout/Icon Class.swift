//
//  Icon Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

func setTableViewIcon(catagory: Int)-> UIImage {
    
    var thisImage:UIImage
    
    switch catagory {
    case 0: //  .camera:
        thisImage = UIImage(named: "cameraIcon")!
    case 1: //  .primes:
        thisImage = UIImage(named: "lensIcon")!
    case 2: //  .macros:
        thisImage = UIImage(named: "lensIcon")!
    case 3: //  .probeLens:
        thisImage = UIImage(named: "lensIcon")!
    case 4: //  .zoomLens:
        thisImage = UIImage(named: "lensIcon")!
    case 5: //  .aks:
        thisImage = UIImage(named: "gearIcon")!
    case 6: //  .finder:
        thisImage = UIImage(named: "gearIcon")!
    case 7: //  .filters:
        thisImage = UIImage(named: "gearIcon")!
    case 8: //  .support:
        thisImage = UIImage(named: "gearIcon")!
    default:
        thisImage = UIImage(named: "manIcon")!
    }
    return thisImage
}
