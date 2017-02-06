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
    
    var thePrimes = String()
    
    /// put camera / lens logic here
    // put prime lens selection here
    // send origingal array to lenses vc
    // retrieve edited array before segue back
    
    func appendTableViewArray(title: String, detail: String, icon: UIImage, compState: [Int] ) {   // when Adding to tableview in main VC
        
        if compState[1]  == 0 { // if selection is a camera
            
            var newRow = [Any]()
            newRow.append(title)
            newRow.append(detail)
            newRow.append(icon)
            tableViewArray.append(newRow)
        } else {        //  this is a lens
            var newRow = [Any]()
            newRow.append(title)
            setPrimesKit(compState: compState)  // get what prime lenses are
            newRow.append(tableViewArrays.thePrimes) // add prime lens string to tableview array
            newRow.append(icon)
            tableViewArray.append(newRow)
        }
    }
    
    /// populate tableview in Lens VC
    func lensTableView() {
        
        let lastElement = tableViewArray.count - 1              // find last element,
        let lenses = tableViewArray[lastElement][1] as? String  // find lens string in tableview array
        originalArray = (lenses?.components(separatedBy: ","))! // split to array for lens tableview
        editedLensArray = originalArray                         // remember original array
    }
    
    ///  Edit list of lenses in lens VC
    func removeFromList(index: Int) { editedLensArray.remove(at: index) } // remove lens to Lens VC
    
    func addToList(index: Int ) {   //   add lens to Lens VC- need to test against a dynamic array esp, last element
        let content = originalArray[index]
        editedLensArray.insert(content, at: index)
    }
    
    func returnEditdedLesesToTableviewArray() {
        let lastElement = tableViewArray.count - 1              // find last element,
        let editedLensString =  editedLensArray.joined(separator: ", ")
        tableViewArray[lastElement][1] = editedLensString
    }
    
    func setPrimesKit(compState: [Int]) {
        // Zeiss Prime Section
        thePrimes = "I dont know what this is"
        // primes "Zeiss" "Master Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 0 {
            thePrimes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZMP"
        }
        
        // primes "Zeiss" "ultra Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 1 {
            thePrimes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZUP"
        }
        
        // primes "Zeiss" "super speeds"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 2 {
            thePrimes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZSS"
        }
        
        // Leica Prime Section
        // primes "Leica" "Summilux-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 0 {
            thePrimes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Summilux-C"
        }
        
        // primes "Leica" "Summicron-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 1 {
            thePrimes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Summicron-C"
        }
        
        // primes "Leica" "Telephoto"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 2 {
            thePrimes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Telephoto"
        }
        
        // Canon Prime Section
        // primes "canon" "K-35"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 0 {
            thePrimes = "12mm, 18mm, 21mm, 35mm, 40mm,  Canon, K-35"
        }
        
        // primes "Canon" "Telephoto"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 1 {
            thePrimes =  "12mm, 18mm, 21mm, 35mm, 40mm,  Canon, Telephoto"
        }
        
        // Cooke Prime Section
        // primes "Cooke" "i5"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 0 {
            thePrimes =  "12mm, 18mm, 21mm, 35mm, 40mm, Cooke, i5"
        }
        
        // primes "Cooke" "S4"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 1 {
            thePrimes =  "12mm, 18mm, 21mm, 35mm, 40mm, Cooke, S4"
        }
        
        // primes "Cooke" "Speed Panchro"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 2 {
            thePrimes =  "12mm, 18mm, 21mm, 35mm, 40mm,  Cooke, Speed Panchro"
        }
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
