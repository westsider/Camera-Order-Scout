//
//  Equipment Class.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/4/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//
//  Quantity    -   Catagory    -   Maker   -   setCamModel     -   lenses

//      1           Camera      -   Arri    -   Alexa                                   0
//      1       -   Primes      -   Zeiss   -   Master Primes   -   25mm 50mm 75mm      1
//      1       -   AKS         -   Select Items                                        5
//                  Finder          Std/Anamorphic                                      6
//                  Filters         Select Item                                         7
//                  Support         Select Item                                         8

// finish populating the picker AKS, Finder, Filters, Support

import Foundation

class Equipment {
    
    /// Array to only fill the 4 wheel picker
    var pickerArray = [Quantity, Catagory.allValues, MakerCamera.allValues,setCamModel(maker: .arri)]
    var prevCatagory = 0
    var pickerState = [0,0,0,0]
    var pickerSelection = ["nil","nil","nil","nil"]
    
    
    func setPickerArray(component: Int, row: Int, lastCatagory: Int )   {
/*
 0   camera
 1   prime
 2   macro
 3   probe
 4   zoom
 5   aks
 6   finder
 7   filters
 8   support*/
 
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
                    pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .innovision)] // probe
                case 4:
                    pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues,setZoomModel(maker: .angenieux)] // zoom
                case 5:    
                    pickerArray = [Quantity, Catagory.allValues, MakerAKSFiltersSupport.allValues, setModelEmpty() ] // aks
                case 6:
                    pickerArray = [Quantity, Catagory.allValues, MakerFinder.allValues, setFinderModel(maker: .standard)] // finder
                case 7:
                    pickerArray = [Quantity, Catagory.allValues, MakerAKSFiltersSupport.allValues, setModelEmpty()] // filters
                case 8:
                    pickerArray = [Quantity, Catagory.allValues, MakerAKSFiltersSupport.allValues, setModelEmpty() ] // support
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
                    case 4: //  prevCatagory = ProbeLens and Maker = century
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .century)]
                    case 5: //  prevCatagory = ProbeLens and Maker = optex
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, setProbeModel(maker: .optex)]
                    default:
                        pickerArray = [Quantity, Catagory.allValues, MakerProbe.allValues, ["Array ","out ", "of ", "index"]]
                    }
                    
                case 4: // zooms
                    switch row {
                    case 0:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .angenieux)]
                    case 1:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .fujinon)]
                    case 2:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .cooke)]
                    case 3:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .zeissVP)]
                    case 4:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .hawk)]
                    case 5:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .century)]
                    case 6:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .canon)]
                    case 7:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, setZoomModel(maker: .anamorphic)]
                    default:
                        pickerArray = [Quantity, Catagory.allValues, MakerZoom.allValues, ["Array ","out ", "of ", "index"]]
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
