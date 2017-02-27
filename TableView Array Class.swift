//
//  TableView Array Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/5/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//      0               1              2            3
//  Quantity    -   Catagory    -   Maker   -   setCamModel     -   lenses

//      0           Camera      -   Arri    -   Alexa                                   0
//      1       -   Primes      -   Zeiss   -   Master Primes   -   25mm 50mm 75mm      1
//      2           Macros          Zeiss       Mastet
//      3           Probe Lens
//      4           Zoom Lens
//      5       -   AKS         -   Select Items                                        5
//      6           Finder          Std/Anamorphic                                      6
//      7           Filters         Select Item                                         7
//      8           Support         Select Item                                         8


//  this function needs to change to have 2 arrays... 1 for lens selection and 1 for tableview / share
//  ... or I could strip extra text out when its added to tableview

//  best is for picker to set 2 string arrays and

//  send them to lens vc for editing then
//  return a string to tableview

import Foundation
import UIKit

/// construct a 2D array to populate main equipment Tableview. Populate and edit Lenses tableView in Lens VC
class TableViewArrays {
    
    var tableViewArray = [[Any]]()  // populates the Main Tableview
    
    var originalArray = [String]()
    
    var editedLensArray = [String]()
    
    var thePrimes = [String]()
    
    var displayLensArray = [String]()
    
    func setTableViewIcon(title: String )-> UIImage {
        
        let image = UIImage(named: "manIcon")!
        
        let catagory = title
        
        if catagory.range(of:"Camera") != nil {
            return UIImage(named: "cameraIcon")!
        }
        
        if catagory.range(of:"Primes") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"Macros") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"Probe Lens") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"Zoom Lens") != nil {
            return UIImage(named: "lensIcon")!
        }
        
        if catagory.range(of:"AKS") != nil {
            return UIImage(named: "gearIcon")!
        }
        
        if catagory.range(of:"Finder") != nil {
            return UIImage(named: "gearIcon")!
        }
        
        if catagory.range(of:"Filters") != nil {
            return UIImage(named: "gearIcon")!
        }
        
        if catagory.range(of:"Support") != nil {
            return UIImage(named: "gearIcon")!
        }
        return image
    }
    
    /// add picker selection to tableview array
    func appendTableViewArray(title: String, detail: String, compState: [Int] ) {   // when Adding to tableview in main VC
        
        var newRow = [Any]()
        newRow.append(title)
        newRow.append(detail)
        newRow.append(setTableViewIcon(title: title))
        tableViewArray.append(newRow)
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
    
    
    // picker sends 2 arrays to lens selection, lens selection edits both arrays, array in converted to string for tableview and share
    /// sets the array to pas in to the edit lenses vc
    func setPrimesKit(compState: [Int]) {
        // Zeiss Prime Section
        thePrimes = ["I dont know what this is"]
        // primes "Zeiss" "Master Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 0 {
            
            thePrimes   = ["12mm", "14mm", "16mm", "18mm", "21mm", "25mm", "27mm",
                           "32mm", "35mm","40mm", "50mm", "65mm", "75mm", "100mm", "135mm", "150mm"]
            
            displayLensArray   = ["12mm    T 1.3   ^16in",
                                  "14mm    T 1.3   ^14in",
                                  "16mm    T 1.3   ^14in",
                                  "18mm    T 1.3   ^14in",
                                  "21mm    T 1.3   ^14in",
                                  "25mm    T 1.3   ^14in",
                                  "27mm    T 1.3   ^14in",
                                  "32mm    T 1.3   ^14in",
                                  "35mm    T 1.3   ^14in",
                                  "40mm    T 1.3   ^16in",
                                  "50mm    T 1.3   ^20in",
                                  "65mm    T 1.3   ^2ft 3in",
                                  "75mm    T 1.3   ^2ft 9in",
                                  "100mm   T 1.3   ^3ft 6in",
                                  "135mm   T 1.3   ^3ft 3in",
                                  "150mm   T 1.3   ^4ft 11in"]
            
        }
        
        // primes "Zeiss" "ultra Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 1 {
            thePrimes   = [ "8mm","10mm","12mm","14mm","16mm","20mm","24mm","28mm","32mm",
                            "40mm","50mm","65mm","85mm","100mm","135mm","180mm"]
            
            displayLensArray   = [ "8mm     T 2.8   ^14in",
                                   "10mm    T 2.1   ^14in",
                                   "12mm    T 2     ^12in",
                                   "14mm    T 1.9   ^9in",
                                   "16mm    T 1.9   ^10in",
                                   "20mm    T 1.9   ^11in",
                                   "24mm    T 1.9   ^12in",
                                   "28mm    T 1.9   ^11in",
                                   "32mm    T 1.9   ^14in",
                                   "40mm    T 1.9   ^15in",
                                   "50mm    T 1.9   ^2ft",
                                   "65mm    T 1.9   ^2ft 3in",
                                   "85mm    T 1.9   ^3ft",
                                   "100mm   T 1.9   ^3ft 3in",
                                   "135mm   T 1.9   ^5ft",
                                   "180mm   T 1.9   ^8ft 6in" ]
        }
        
        // primes "Zeiss" "super speeds"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 2 {
            thePrimes   = [ "18mm","25mm","35mm","50mm","65mm","85mm"]
            
            displayLensArray = [ "18mm      T 1.3   ^10in",
                                 "25mm      T 1.3   ^10in",
                                 "35mm      T 1.3   ^1ft 2in",
                                 "50mm      T 1.3   ^2ft 6in",
                                 "65mm      T 1.3   ^2ft 4in",
                                 "85mm      T 1.3   ^3ft"]
        }
        
        // primes "Zeiss" "standard speeds"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 3 {
            thePrimes   = [ "10mm","12mm","14mm","16mm","20mm","24mm","28mm","32mm",
                            "40mm","50mm","85mm","100mm","135mm","180mm"]
            
            displayLensArray   = ["10mm    T 2.1   ^14in",
                                  "12mm    T 2.1   ^10in",
                                  "14mm    T 2.1   ^9in",
                                  "16mm    T 2.1   ^5in",
                                  "20mm    T 2.1   ^8in",
                                  "24mm    T 2.1   ^8in",
                                  "28mm    T 2.1   ^11in",
                                  "32mm    T 2.1   ^1ft 4in",
                                  "40mm    T 2.1   ^1ft 4in",
                                  "50mm    T 2.1   ^1ft 4in",
                                  "85mm    T 2.1   ^3ft",
                                  "100mm   T 2.1   ^3ft 4in",
                                  "135mm   T 2.1   ^5ft",
                                  "180mm   T 3     ^5ft"]
        }
        
        // primes "Zeiss" "Compact S2"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 4 {
            thePrimes   = [ "18mm","21mm","25mm","28mm","35mm",
                            "50mm","85mm", "100mm", "135mm"]
            
            displayLensArray = ["15mm    T 2.9   ^12in",
                                "18mm    T 3.6   ^12in",
                                "21mm   T 2.9   ^10in",
                                "25mm   T 2.1   ^10in",
                                "28mm   T 2.1   ^10in",
                                "35mm   T 2.1   ^12in",
                                "50mm   T 2.1   ^18in",
                                "85mm   T 2.1   ^3ft 3in",
                                "100mm  T 2.1   ^2ft 6in",
                                "135mm  T 2.1   ^3ft 3in"]
        }
        
        // Leica Prime Section
        // primes "Leica" "Summilux-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 0 {
            thePrimes = [ "16mm", "18mm","21mm","25mm","29mm","35mm",
                          "40mm","50mm","65mm","75mm","100mm","135mm"]
            
            displayLensArray = ["16mm   T 1.4    ^14in",
                                "18mm   T 1.4    ^14in",
                                "21mm  T 1.4    ^12in",
                                "25mm  T 1.4    ^12in",
                                "29mm  T 1.4    ^18in",
                                "35mm  T 1.4    ^14in",
                                "40mm  T 1.4    ^16in",
                                "50mm  T 1.4    ^20in",
                                "65mm  T 1.4    ^18in",
                                "75mm  T 1.4    ^2ft 3in",
                                "100mm T 1.4    ^2ft 11in",
                                "135mm T 1.4    ^4ft 1in"]
        }
        
        // primes "Leica" "Summicron-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 1 {
            thePrimes = [ "15mm", "18mm","21mm","25mm","29mm","35mm",
                          "40mm","50mm","75mm","100mm","135mm"]
            
            displayLensArray  = [ "15mm  T 2.0    ^12in",
                                  "18mm  T 2.0    ^12in",
                                  "21mm  T 2.0    ^12in",
                                  "25mm  T 2.0    ^12in",
                                  "29mm  T 2.0    ^12in",
                                  "35mm  T 2.0    ^14in",
                                  "40mm  T 2.0    ^18in",
                                  "50mm  T 2.0    ^2ft",
                                  "75mm  T 2.0    ^2ft 7in",
                                  "100mm T 2.0    ^3ft 3in",
                                  "135mm T 2.0    ^5ft"]
        }
        
        // primes "Leica" "Telephoto"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 2 {
            thePrimes = [ "180mm","280mm"]
            
            displayLensArray   = [ "180mm   T 2  ^5",
                                   "280mm   T 2  ^8"]
        }
        
        // Canon Prime Section
        // primes "canon" "K-35"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 0 {
            thePrimes  = [ "18mm","24mm", "35mm", "55mm","85mm"]
            
            displayLensArray    = [ "18mm   T 1.5   ^12in",
                                    "24mm   T 1.5   ^12in",
                                    "35mm   T 1.5   ^12in",
                                    "55mm   T 1.5   ^2ft",
                                    "85mm   T 1.5   ^3ft"]
        }
        
        // primes "Canon" "Telephoto"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 1 {
            thePrimes = [ "200mm T2","200 T2.8", "300mm", "400mm"]
            
            displayLensArray = [ "200mm     T2      ^10ft",
                                 "200mm     T2.8    ^4ft 9in",
                                 "300mm     T2.8    ^10ft",
                                 "400mm     T2.8    ^15ft"]
        }
        
        // Cooke Prime Section
        // primes "Cooke" "i5"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 0 {
            thePrimes = [ "18mm","25mm","32mm","40mm","50mm","65mm","75mm","100mm","135mm"]
            
            displayLensArray  = [ "18mm   T 1.4   ^5in",
                                  "25mm   T 1.4   ^5in",
                                  "32mm   T 1.4   ^5in",
                                  "40mm   T 1.4   ^7in",
                                  "50mm   T 1.4   ^11in",
                                  "65mm   T 1.4   ^15in",
                                  "75mm   T 1.4   ^17in",
                                  "100mm  T 1.4   ^21in",
                                  "135mm  T 1.4   ^21in"]
        }
        
        // primes "Cooke" "S4"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 1 {
            thePrimes = ["12mm", "14mm", "16mm", "18mm", "21mm", "25mm", "27mm",
                         "32mm", "35mm","40mm", "50mm", "65mm", "75mm", "100mm", "135mm", "150mm", "180mm"]
            
            displayLensArray = ["12mm   T 2   ^9in",
                                "14mm   T 2   ^9in",
                                "16mm   T 2   ^9in",
                                "18mm   T 2   ^9in",
                                "21mm   T 2   ^9in",
                                "25mm   T 2   ^9in",
                                "27mm   T 2   ^10in",
                                "32mm   T 2   ^12in",
                                "35mm   T 2   ^14in",
                                "40mm   T 2   ^16in",
                                "50mm   T 2   ^20in",
                                "65mm   T 2   ^27in",
                                "75mm   T 2   ^30in",
                                "100mm  T 2   ^36in",
                                "135mm  T 2   ^30in",
                                "150mm  T 2   ^42in",
                                "180mm  T 2   ^51in"]
        }
        
        /// primes "Cooke" "Speed Panchro"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 2 {
            thePrimes = ["18mm", "25mm", "32mm", "40mm", "50mm", "75mm", "100mm Macro", "152mm Macro"]
            
            displayLensArray  = ["18mm  T 2.2   ^7in",
                                 "25mm  T 2.3   ^11in",
                                 "32mm  T 2.3   ^8in",
                                 "40mm  T 2.3   ^9in",
                                 "50mm  T 2.3   ^12in",
                                 "75mm  T 2.3   ^22in",
                                 "100mm Macro  T 2.8   ^3in",
                                 "152mm Macro  T 3.2   ^3in"]
        }
        
        /// arri macro
        if compState[1] == 2 && compState[2] == 0 && compState[3] == 0 {
            thePrimes = ["17.5mm", "21mm", "25mm", "32mm","40mm","50mm", "65mm", "90mm", "102mm"]
            
            displayLensArray   = ["17.5mm   T 1.0   ^10in",
                                  "21mm     T 1.0   ^10in",
                                  "25mm     T 1.0   ^10in",
                                  "32mm     T 1.0   ^10in",
                                  "40mm     T 1.0   ^1ft 2in",
                                  "50mm     T 1.0   ^1ft 2in",
                                  "65mm     T 1.0   ^1ft 2in",
                                  "90mm     T 1.0   ^1ft 8in",
                                  "102mm    T 1.0   ^2ft 6in"]
        }
        
        // master prime macro
        if compState[1] == 2 && compState[2] == 1 && compState[3] == 0 {
            thePrimes = [ "100mm"]
            
            displayLensArray = [ "100mm      T 2   ^13.75in"]
        }
        
        // probe lens  innovosion probe II+
        if compState[1] == 3 && compState[2] == 0 && compState[3] == 0 {
            thePrimes = ["9mm", "12mm", "16mm", "20mm", "28mm", "32mm", "40mm" , "55mm"]
            
            displayLensArray = ["9mm    T 6.3", "12mm    T 6.3", "16mm    T 6.3", "20mm    T 6.3", "28mm    T 6.3", "32mm    T 6.3", "40mm    T 6.3" , "55mm    T 6.3"]
        }
        // probe lens  trex probe
        if compState[1] == 3 && compState[2] == 1 && compState[3] == 0 {
 
            thePrimes   = ["5.5-20mm", "8-18mm", "17-35mm", "32-70mm", "55-112mm Macro"]
            displayLensArray = ["5.5-20mm   T 7.1", "8-18mm   T 7.1", "17-35mm   T 7.1", "32-70mm   T 7.1", "55-112mm   T 7.1 Macro"]
        }
        
        // probe lens  revolution probe
        if compState[1] == 3 && compState[2] == 2 && compState[3] == 0 {
            
            thePrimes  = ["9.8mm", "12mm", "16mm", "20mm", "24mm", "32mm", "40mm" , "65mm"]
            displayLensArray  = ["9.8mm T 7.5", "12mm T 7.5", "16mm T 7.5", "20mm T 7.5", "24mm T 7.5", "32mm T 7.5", "40mm T 7.5" , "65mm T 7.5"]
        }
        
        // probe lens  skater scope
        if compState[1] == 3 && compState[2] == 3 && compState[3] == 0 {
            
            thePrimes   = ["PL Mount"]
            displayLensArray = ["PL Mount"]
        }
        
        // probe lens  century periscope
        if compState[1] == 3 && compState[2] == 4 && compState[3] == 0 {
            
            thePrimes   = ["PL Mount"]
            displayLensArray = ["PL Mount"]
        }
        
        // probe lens  optex probe
        if compState[1] == 3 && compState[2] == 5 && compState[3] == 0 {
            
            thePrimes  = ["10mm", "14mm", "20mm", "28mm"]
            displayLensArray = ["10mm   T 5.6", "14mm   T 5.6", "20mm   T 5.6", "28mm   T 5.6"]
        }
        /*
 if ( savedCompZero == 3  && savedCompOne == 0){
 equipmentArray[1]   = ["Innovision","T-Rex", "Revolution", "Skater", "Century", "Optex"]
 equipmentArray[2]    = ["Probe II+"]
 lensArray   = ["9mm", "12mm", "16mm", "20mm", "28mm", "32mm", "40mm" , "55mm"]
 
 displayLensArray = ["9mm    T 6.3", "12mm    T 6.3", "16mm    T 6.3", "20mm    T 6.3", "28mm    T 6.3", "32mm    T 6.3", "40mm    T 6.3" , "55mm    T 6.3"]
 }
 // t rex probe
 if ( savedCompZero == 3  && savedCompOne == 1){
 equipmentArray[2]    = ["Probe"]
 lensArray   = ["5.5-20mm", "8-18mm", "17-35mm", "32-70mm", "55-112mm Macro"]
 displayLensArray = ["5.5-20mm   T 7.1", "8-18mm   T 7.1", "17-35mm   T 7.1", "32-70mm   T 7.1", "55-112mm   T 7.1 Macro"]
 }
 // revolution probe
 if ( savedCompZero == 3  && savedCompOne == 2){
 equipmentArray[2]    = ["Probe"]
 lensArray   = ["9.8mm", "12mm", "16mm", "20mm", "24mm", "32mm", "40mm" , "65mm"]
 displayLensArray  = ["9.8mm T 7.5", "12mm T 7.5", "16mm T 7.5", "20mm T 7.5", "24mm T 7.5", "32mm T 7.5", "40mm T 7.5" , "65mm T 7.5"]
 }
 // skater Scope
 if ( savedCompZero == 3  && savedCompOne == 3){
 equipmentArray[2]    = ["Scope"]
 lensArray   = ["PL Mount"]
 displayLensArray = ["PL Mount"]
 }
 // century Periscope
 if ( savedCompZero == 3  && savedCompOne == 4){
 equipmentArray[2]    = ["Periscope"]
 lensArray   = ["PL Mount"]
 displayLensArray = ["PL Mount"]
 }
 // Optex probe
 if ( savedCompZero == 3  && savedCompOne == 5){
 equipmentArray[2]    = ["Excellence"]
 lensArray   = ["10mm", "14mm", "20mm", "28mm"]
 displayLensArray = ["10mm   T 5.6", "14mm   T 5.6", "20mm   T 5.6", "28mm   T 5.6"]
 }
 */
 
        // AKS
        if compState[1] == 5 {
            thePrimes =  ["7in On Board Monitor",
                          "Remote Focus",
                          "Hand Held Rig",
                          "Easy Rig 500",
                          "Easy Rig 600",
                          "Easy Rig 700",
                          "Easy Rig 850",
                          "Arri Follow Focus 4 / Hand Held FF4 (Complete)",
                          "5 inch Assistant Color Monitor(w/Swing Bracket + 2 Cables)",
                          "Arri 24Volt Remote Switch (w/Extension Cable)",
                          "Base Plate Top, Base Plate Bottom (w/Quick Release Plate)",
                          "Follow Focus Whips (Short + Long)",
                          "Speed Crank",
                          "24Volt Splitter Box",
                          "Assistant Lens Light",
                          "Arri Eyepiece Heater Cup (w/2 Cables)",
                          "Iris Rods",
                          "MB14 Mattebox (4 Stage - 2 geared, 2 standard)",
                          "MB14 2-Stage Attachment",
                          "MB18 Mattebox (3 Stage - 1 geared, 2 standard)",
                          "MB20 Mattebox (4 Stage - 2 geared, 2 standard)",
                          "6x6 Sunshade",
                          "4x5 Sunshade",
                          "6x6 Arri Clip-on / Hand Held Mattebox (Regular & Angenieux 12-1)",
                          "4x5 Arri Clip-on / Hand Held Mattebox",
                          "4.5” Round Clip-on Sun Shade",
                          "138mm Round Clip-on Sun Shade",
                          "Series 9 Clip-on Sun Shade",
                          "Spider Hand Held Rig",
                          "Element Technica Mantis Hand Held Rig",
                          "C-Motion Lens Control System",
                          "Preston FI&Z II System",
                          "Preston FI&Z III System",
                          "Hand Held & StudioRain Deflectors",
                          "Weather Protectors & Heater Barnies",
                          "Digi-Clamshell",
                          "Cinetape (Digital Range Finder)",
                          "Cinetape Link 1 (Transmitter & Receiver)",
                          "Film Video Sync Box",
                          "Element Technica “V” Dock (RED) & Base Plate (RED)",
                          "Element Technica Cheese Stick Handle & Cheese Plate (RED)",
                          "Element Technica Iso Plate (Shock Mount) RED)"]
            
            displayLensArray = thePrimes
        }
        
        // Finder
        if compState[1] == 6 {
            thePrimes =  ["Standard Finder", "Anamorphic Finder"]
            
            displayLensArray = thePrimes
        }
        
        // Filters
        if compState[1] == 7 {
            thePrimes =  ["Diopter +1/2 +1 +2 +3",
                          "Achromatic Diopter +1/2 +1 +2 +3",
                          "Split Diopter +1/2 +1 +2 +3",
                          "Optical Flat",
                          "ND .3 .6 .9 1.2 1.5 1.8 2.1",
                          "ND IR .3 .6 .9 1.2 1.5 1.8 2.1",
                          "Platinum IRND .3 .6 .9 1.2 1.5 1.8 2.1",
                          "True ND IR .3 .6 .9 1.2 1.5 1.8 2.1",
                          "Polarizer",
                          "Polarizer True Circular",
                          "Polarizer Ultra",
                          "Enhancer",
                          
                          "------- Diffusion ------",
                          "Black Diffusion FX",
                          "Black Dot Textured Screen",
                          "Black Frost",
                          "Black Net",
                          "Black Promist",
                          "Black Supa Frost",
                          "Double Fog",
                          "Promist",
                          "Soft Centric",
                          "Soft Contrast",
                          "Soft FX",
                          "Scenic Fog",
                          "Classic Black Soft",
                          "Classic Soft",
                          "Fog",
                          "White Frost",
                          "White Net",
                          "White Supa Frost",
                          
                          "------- EFX ------",
                          "Star 4 Point (2mm, 3mm, 4mm)",
                          "Star 6 Point (2mm, 3mm, 4mm)",
                          "Star 8 Point (2mm, 3mm, 4mm)",
                          "Streak",
                          "Blue Streak Effect (1mm, 2mm, 3mm)",
                          "Blue Vision Medium",
                          "Blue Vision Ultra Fine",
                          
                          "------- Correction ------",
                          "81",
                          "82",
                          "85",
                          "812",
                          "80A",
                          "80B",
                          "80C",
                          "80D",
                          "81A",
                          "81B",
                          "81C",
                          "81D",
                          "81EF",
                          "81EF ND .3 .6 .9",
                          "82A",
                          "82B",
                          "82C",
                          "85 ND .3 .6 .9 1.2",
                          "85 Linear Polarizer",
                          "85 Circular Polarizer",
                          "85B",
                          "85B ND .3 .6 .9 1.2",
                          "85C"
            ]
            
            displayLensArray = thePrimes
            
            /*
             "Antique Suede 1
             "Antique Suede 2
             "Antique Suede 3
             
             ND Blender Horizontal
             ND Blender Vertical
             Blink Filters
             Blue
             Blue Attenuator
             Blue Grad Hard and Soft Edge
             Blue Grey Grad
             
             Chocolate
             Chocolate Grad Hard and Soft Edge
             Clairmont In-camera filter kit
             
             Color Correction Magenta
             Color Correction Green
             Color Correction Yellow
             Cool Blue Grad
             Coral
             Coral Attenuator
             Coral Grad Hard and Soft Edge
             Cranberry
             Cranberry Grad
             Cyan
             Cyan Attenuator
             Cyan Grad
             Day 4 Night
             Day 4 Night Cool
             Day 4 Night Mono
             Diffusion
             
             EK 87
             
             FLB
             FLD
             Flesh Net
             
             Glimmer Glass
             Gold
             Gold Diffusion FX
             Golden Sepia
             Grape
             Grape Grad
             Green
             Green Attenuator
             Green Grad
             Green/Yellow
             Haze 2A
             HD Soft
             HD UV
             Hollywood Black Magic
             Hollywood Star
             Hot Mirror IR
             Hyper Star
             
             LLD
             Low Contrast
             Magenta Attenuator
             Magenta Grad
             NBRA
             
             ND Attenuator Grad
             ND Corona 1" Spot
             ND Corona 2" Spot
             ND Elliptical 1" Spot
             ND Elliptical 2" Spot
             ND Grad Hard and Soft Edge
             North Star
             
             Orange
             Pink Attenuator
             Pink Grad Hard and Soft Edge
             
             Plum Grad
             Red
             Red Attenuator
             Red Grad
             Red Net
             
             Sepia
             Sepia Grad
             Skin Net
             Sky Blue
             Skyfire
             Smoque
             
             Storm Blue
             Storm Blue Grad
             Straw
             Straw Grad Hard and Soft Edge
             
             Sunset
             Supa Frost
             Tangerine
             Tangerine Grad
             Tobacco
             Tobacco Grad
             Tropical Blue Grad
             True Cut 750 IR
             
             True Streak Confetti
             Twilight
             Ultra Contrast
             
             UV 16
             Vector Star
             Warm Black Promist
             Warm Pola
             Warm Promist
             Warm Soft FX
             
             Yellow
             Yellow Grad
             */
        }
        
        // Support
        if compState[1] == 8 {
            thePrimes =  ["Sachtler Cine 30 HD",
                          "Sachtler Studio 9+9 Head",
                          
                          "O’Connor Ultimate 25/75 Head",
                          "O’Connor Ultimate 2060 Head",
                          
                          "Cartoni Sigma Head",
                          "Cartoni Master Head",
                          "Cartoni Gamma Head",
                          "Cartoni C40S Dutch Head",
                          "Cartoni Lambda Head",
                          "Cartoni Lambda 3 axis Head",
                          
                          "Arri Gear Head",
                          "Panaviaion Gear head",
                          
                          "Weaver Steadman Head",
                          "Weaver Steadman 3 axis Head",
                          "Ronford F-7 Head",
                          
                          "Tango Swing Plate",
                          
                          "Original Slider",
                          "Slider",
                          "P+S Technic Skater Jr",
                          
                          "Standards Sticks",
                          "Baby Sticks",
                          "High Hat",
                          "Low Hat"]
            
            displayLensArray =  thePrimes
        }
        
    }
    
    //MARK: - format message
    /// format message string
    func messageContent()-> String {
        var message = ""
        var counter = 0
        for line in tableViewArray {
            if counter == 0 {
                message += "\nCamera  Order\n\r"
                message += "\(line[0])\n\r"
                
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
    
    func populateArrays(array: [String], reversed: Bool) {
        // if this is a lens kit
        original = array
        edited = original
        // else if switchon = false this is aks, filters, support
        if reversed == false {
            var editedReverse = [String]()
            let i = edited.count
            var counter = 0
            
            while counter < i {
                counter += 1
                editedReverse.append("#")
            }
            print("edited    \(edited.count)")
            print("editedRev \(editedReverse.count)")
            edited = editedReverse
        }
        
    }
    
    /// edit lens list using tableview switches
    func updateArray(index: Int, switchPos: Bool ) {
        
        if index < edited.count {
            
            if switchPos == false {
                edited[index] = "#"
            } else {
                edited[index] = original[index]
            }
            
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
            } else {
                hasHash = false
            }
        }
        // convert to string
        returnedString = edited.joined(separator: ", ")
    }
}
