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
    var pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues,setCamModel(maker: .arri)]
    var prevCatagory = 0
    var pickerState = [0,0,0,0]
    var pickerSelection = ["nil","nil","nil","nil"]
    
    
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
    
    func setPrimesKit(compState: Array<Int>)-> String {
        // Zeiss Prime Section
        var primes = "I dont know what this is"
        // primes "Zeiss" "Master Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 0 {
            primes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZMP"
        }
        
        // primes "Zeiss" "ultra Primes"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 1 {
            primes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZUP"
        }
        
        // primes "Zeiss" "super speeds"
        if compState[1] == 1 && compState[2] == 0 && compState[3] == 2 {
            primes = "12mm, 18mm, 21mm, 35mm, 40mm, Zeiss ZSS"
        }
        
        // Leica Prime Section
        // primes "Leica" "Summilux-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 0 {
            primes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Summilux-C"
        }
        
        // primes "Leica" "Summicron-C"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 1 {
            primes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Summicron-C"
        }
        
        // primes "Leica" "Telephoto"
        if compState[1] == 1 && compState[2] == 1 && compState[3] == 2 {
            primes = "12mm, 18mm, 21mm, 35mm, 40mm, Leica, Telephoto"
        }
        
        // Canon Prime Section
        // primes "canon" "K-35"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 0 {
            primes = "12mm, 18mm, 21mm, 35mm, 40mm,  Canon, K-35"
        }
        
        // primes "Canon" "Telephoto"
        if compState[1] == 1 && compState[2] == 2 && compState[3] == 1 {
            primes =  "12mm, 18mm, 21mm, 35mm, 40mm,  Canon, Telephoto"
        }
        
        // Cooke Prime Section
        // primes "Cooke" "i5"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 0 {
            primes =  "12mm, 18mm, 21mm, 35mm, 40mm, Cooke, i5"
        }
        
        // primes "Cooke" "S4"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 1 {
            primes =  "12mm, 18mm, 21mm, 35mm, 40mm, Cooke, S4"
        }
        
        // primes "Cooke" "Speed Panchro"
        if compState[1] == 1 && compState[2] == 3 && compState[3] == 2 {
            primes =  "12mm, 18mm, 21mm, 35mm, 40mm,  Cooke, Speed Panchro"
        }
        
        return primes
    }
}
