//
//  Equipment Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/4/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation

class Equipment {
    
    /// Array to only fill the 4 wheel picker
    var pickerArray = [[String]]()
    /// Holds a 2D array to populate Title + Detail correctly in a tableview E.G.    [["Warren Hansen Director of Photography", "1 Camera", "1 Primes Zeiss Master Primes"], ["Camera Order Nike 12 / 20 / 2016", "Arri Alexa", "12mm18mm21mm35mm40mmZeiss ZMP"]]
    var pickerSelected = [String]()
    var thisCompState = [Int]()
    var maker: Maker
    
    init(pickerArray: [[String]], pickerSelected: [String], thisCompState: [Int], maker: Maker ) {
        self.pickerArray = pickerArray
        self.pickerSelected = pickerSelected
        self.thisCompState = thisCompState
        self.maker = maker
    }
    
    func setPickerArray(component: Int, row: Int, lastCatagory: Int )   {
        
        if component < 3 {
            switch component {
                
            case 1: // change Catagory and maker populates
                switch row {
                case 0:
                    pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues,setCamModel(maker: .arri)] // cam
                case 1:
                    pickerArray = [Quantity, Catagory.allValues, MakerPrimes.allValues,setPrimesModel(maker: .zeiss)] // prime
                case 2:
                    pickerArray = [Quantity, Catagory.allValues, MakerMacros.allValues, setMacrosModel(maker: .arri)] // macro
                case 3:
                    pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .innovision)] // probe, zoom, aks,
                default:
                    pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues,["Array ","out ", "of ", "index"]]
                }
                
            case 2:  //  Based on Catagory change maker - model populates
                switch lastCatagory {
                case 0:     //  prevCatagory = Camera and Maker = Arri
                    switch row {
                    case 0:
                        pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .arri)]
                    case 1: //  prevCatagory = Camera and Maker = Red
                        pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .red)]
                    case 2: //  prevCatagory = Camera and Maker = Phantom
                        pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .phantom)]
                    case 3: //  prevCatagory = Camera and Maker = Panavision
                        pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues, setCamModel(maker: .panavision)]
                    default:
                        pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues, ["Array ","out ", "of ", "index"]]
                    }
                    
                case 1:     //  prevCatagory = Primes and Maker = Zeiss
                    switch row {
                    case 0:
                        pickerArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .zeiss)]
                    case 1: //  prevCatagory = Primes and Maker = leics
                        pickerArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .leica)]
                    case 2: //  prevCatagory = Primes and Maker = cannon
                        pickerArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .canon)]
                    case 3: //  prevCatagory = Primes and Maker = cooke
                        pickerArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, setPrimesModel(maker: .cooke)]
                    default:
                        pickerArray = [Quantity, Catagory.allValues, MakerPrimes.allValues, ["Array ","out ", "of ", "index"]]
                    }
                    
                case 2:     //  prevCatagory = Macros and Maker = Arri || Zeiss
                    switch row {
                    case 0:
                        pickerArray = [Quantity, Catagory.allValues, MakerMacros.allValues, setMacrosModel(maker: .arri)]
                    case 1: //  prevCatagory = Macros and Maker = Zeiss
                        pickerArray = [Quantity, Catagory.allValues, MakerMacros.allValues, setMacrosModel(maker: .zeiss)]
                    default:
                        pickerArray = [Quantity, Catagory.allValues, MakerMacros.allValues, ["Array ","out ", "of ", "index"]]
                    }
                    
                case 3:     //  prevCatagory = ProbeLens and Maker = Innovision || T-Rex || Revolution || Skater
                    switch row {
                    case 0:
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .innovision)]
                    case 1: //  prevCatagory = ProbeLens and Maker = T-Rex
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .tRex)]
                    case 2: //  prevCatagory = ProbeLens and Maker = Revolution
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .revolution)]
                    case 3: //  prevCatagory = ProbeLens and Maker = Skater
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .skater)]
                    default:
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, ["Array ","out ", "of ", "index"]]
                    }
                default:
                    break
                }
            case 3:  //  change Model -- this logic not needed because wheel 1 and 2 populate compoment 3
                break
            default:
                break
            }
        }
    }
}
