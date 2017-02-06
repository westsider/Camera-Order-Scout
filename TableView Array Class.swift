//
//  TableView Array Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

/// construct a 2D array to populate main equipment Tableview. Populate and edit Lenses tableView in Lens VC
class TableViewArrays {
    
    var tableViewArray = [[Any]]()  // populates the Main Tableview
    
    var originalArray = [String]()
    
    var editedLensArray = [String]()
    
    func appendTableViewArray(title: String, detail: String, icon: UIImage) {   // when Adding to tableview in main VC
        
        var newRow = [Any]()
        newRow.append(title)
        newRow.append(detail)
        newRow.append(icon)
        
        tableViewArray.append(newRow)
    }
    
    /// populate tableview in Lens VC
    func lensTableView() {
        
        let lastElement = tableViewArray.count - 1              // find last element,
        let lenses = tableViewArray[lastElement][1] as? String  // find lenses
        originalArray = (lenses?.components(separatedBy: ","))! // split to array
        editedLensArray = originalArray                         // remember original array
    }
    
    ///  Edit list of lenses in lens VC
    func removeFromList(index: Int) { editedLensArray.remove(at: index) } // remove lens to Lens VC
    
    func addToList(index: Int ) {   //   add lens to Lens VC- need to test against a dynamic array esp, last element
        let content = originalArray[index]
        editedLensArray.insert(content, at: index)
    }
    
    func messageContent()-> String {
        //print(tableViewArray)
        var message = ""
        var counter = 0
        for line in tableViewArray {
            if counter == 0 {
                message += "\(line[0])\n\r"
                message += "\(line[1])\n\r"
            } else {
                message += "\(line[0])\n\(line[1])\n\r"
            }
            counter = counter + 1
        }
        return message
    }
    
    //MARK: - TODO sort list by: camera, primes, macros, probes, zooms, aks ect
}
