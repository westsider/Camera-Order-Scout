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
    
    /// add picker selection to tableview array
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
    
    func removeAll() {
        tableViewArray.removeAll()
    }
    
    /// populate tableview in Lens VC
    func lensTableView() {
        
        let lastElement = tableViewArray.count - 1              // find last element,
        let lenses = tableViewArray[lastElement][1] as? String  // find lens string in tableview array
        originalArray = (lenses?.components(separatedBy: ","))! // split to array for lens tableview
        editedLensArray = originalArray                         // remember original array
    }

    /// send edited lens array back to main tableview array
    func editedLensKitReturendToMainTableView(sendString: String) {
            // convery array to srting
            let lastElement = tableViewArray.count - 1              // find last element,
            tableViewArray[lastElement][1] = sendString  // send
        }
    
    func updateUser(title: String, detail: String) {
        
        tableViewArray[0][0] = title
        tableViewArray[0][1] = detail
        
    }
    
    /// sets the array to pas in to the edit lenses vc
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
        
        // AKS
        if compState[1] == 5 {
            thePrimes =  "7in On Board Monitor, Remote Focus, Hand Held Rig, Easy Rig, Arri Follow Focus 4 / Hand Held FF4 (Complete), 5” Assistant Color Monitor(w/Swing Bracket, 2 Cables), Arri 24Volt Remote Switch (w/Extension Cable), Base Plate Top, Base Plate Bottom (w/Quick Release Plate), Follow Focus Whips (Short + Long), Speed Crank, 24Volt Splitter Box, Assistant Lens Light, Arri Eyepiece Heater Cup (w/2 Cables), Iris Rod s"

            /*
             MB14 Mattebox (4 Stage - 2 geared, 2 standard)
             MB14 2-Stage Attachment
             MB18 Mattebox (3 Stage - 1 geared, 2 standard)
             MB20 Mattebox (4 Stage - 2 geared, 2 standard)
             6x6 Sunshade
             4x5 Sunshade
             6x6 Arri Clip-on / Hand Held Mattebox (Regular & Angenieux 12-1)
             4x5 Arri Clip-on / Hand Held Mattebox
             4.5” Round Clip-on Sun Shade
             138mm Round Clip-on Sun Shade
             Series 9 Clip-on Sun Shade
             Spider Hand Held Rig
             Element Technica Mantis Hand Held Rig
             */
            /*
            C-Motion Lens Control System
            Preston FI&Z II System
            Preston FI&Z III System
            Hand Held & StudioRain Deflectors
            Weather Protectors & Heater Barnies
            Digi-Clamshell
            Cinetape (Digital Range Finder)
            Cinetape Link 1 (Transmitter & Receiver)
            Film Video Sync Box
            Element Technica “V” Dock (RED) & Base Plate (RED)
            Element Technica Cheese Stick Handle & Cheese Plate (RED)
            Element Technica Iso Plate (Shock Mount) RED)
            */
        }
        
        // Finder
        if compState[1] == 6 {
            thePrimes =  "Standard Finder, Anamorphic Finder"
        }
        
        // Filters
        if compState[1] == 7 {
            thePrimes =  "Diopter Set of +1/2 +1 +2 +3, Optical Flat, ND 3 6 9 1.2, ND IR 3 6 9 1.2, Polarizer"
        }
        
        // Support
        if compState[1] == 8 {
            thePrimes =  "Sachtler Cine 30 HD, Sachtler Studio 9+9 Head, O’Connor Ultimate 25/75 Head, O’Connor Ultimate 2060 Head, Cartoni Sigma Head, Cartoni Master Head, Cartoni Dutch Head, Cartoni Gamma Head, Arri Gear Head, Panaviaion Gear head, CARTONI | C40S Dutch Head, Tango Swing Plate, Weaver 3 axis Head, Standards Sticks, Baby Sticks, High Hat, Low Hat"
        }
        /*
         O’Connor Ultimate 25/75 Head
         O’Connor Ultimate 2060 Head
         Cartoni Sigma Head
         Cartoni Master Head
         Cartoni Dutch Head
         Cartoni Gamma Head
         */
        /*
         Cartoni Lambda Head
         Cartoni Lambda 3rd axis Head
         Weaver Steadman Head
         Weaver Steadman 3rd axis Head
         Ronford F-7 Head
         */
    }
    
    //MARK: - format message
    /// format message string
    func messageContent()-> String {
        //print(tableViewArray)
        var message = ""
        var counter = 0
        for line in tableViewArray {
            if counter == 0 {
                message += "\nCamera  Order\n\r"
                message += "\(line[0])\n\r"
                //  message += "\(thisEvent.user.production) \(thisEvent.user.company) \(thisEvent.user.date)\n\r"
                //  message +=  "Weather Forecast for \(thisEvent.user.city)\n\(thisEvent.user.weather)\n\r"
            
            } else {
                message += "\(line[0])\n\(line[1])\n\r"
            }
            counter = counter + 1
        }
        return message
    }
    
    //MARK: - TODO sort list by: camera, primes, macros, probes, zooms, aks ect
}

//MARK:- tableview switches
/// fuctions to use tableview switches to update the lens array
class TableViewSwitches {
    
    var original = [String]()   //["i", "am", "original"]
    var edited =  [String]()    //["i", "am", "edited"]
    var returnedString = String()
    
    func populateArrays(array: [String]) {
        original = array
        edited = original
    }
    
    /// edit lens list using tableview switches
    func updateArray(index: Int, switchPos: Bool ) {
        
        if index < edited.count {
            
            if switchPos == false {
                edited[index] = "#"
            } else {
                edited[index] = original[index]
            }
            print("edited array\(edited)")
            
        } else {
            print("⚡️the index \(index) does not exist you big 🤓")
        }
    }
    
    /// return edited lens string back to pass into main tableview array
    func finalizeLensArray() {   // in segue back to main VC
        var hasHash = true
        while hasHash {
            if let index = edited.index(of: "#") {
                hasHash = true
                edited.remove(at: index)
                print("finalize has removed a hash \(edited)")
            } else {
                hasHash = false
            }
        }
        print("Finalize no hashes: \(edited)")
        // convert to string
        returnedString = edited.joined(separator: ",")
        print("returnedString is: \(returnedString)")
    }
}
