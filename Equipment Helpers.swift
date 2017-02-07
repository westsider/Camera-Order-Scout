//
//  Equipment Helpers.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/4/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import UIKit

//  Quantity    -   Catagory    -   Maker   -   setCamModel     -   lenses

//      1           Camera      -   Arri    -   Alexa                                   0
//      1       -   Primes      -   Zeiss   -   Master Primes   -   25mm 50mm 75mm      1
//      1       -   AKS         -   Select Items                                        5
//                  Finder          Std/Anamorphic                                      6
//                  Filters         Select Item                                         7
//                  Support         Select Item                                         8

// finish populating the picker AKS, Finder, Filters, Support
// what happens when a lens is selected? -- how do i populate the lens tableview array?

// helper  enums + functions for the Equipment class

let Quantity = ["1","2","3","4","5","6","7","8","9"]

enum Catagory {
    case camera, primes, macros, probeLens, zoomLens, aks, finder, filters, support
    
    static let allValues = ["Camera", "Primes", "Macros", "Probe Lens", "Zoom Lens", "AKS", "Finder", "Filters", "Support"]
}

enum MakerCamera {
    case arri, red, phantom, panavision, sony
    
    static let allValues = ["Arri", "Red", "Phantom", "Panavision", "Sony"]
}

enum MakerPrimes {
    case zeiss, leica, canon, cooke
    
    static let allValues = ["Zeiss", "Leica", "Canon", "Cooke"]
}

enum MakerMacros {
    case arri, zeiss
    
    static let allValues = ["Arri", "Zeiss"]
}

enum MakerProbe {
    case innovision, tRex, revolution, skater, century, optex
    
    static let allValues = ["Innovision", "T-Rex", "Revolution", "Skater", "Century", "Optex"]
}

enum MakerAKSFiltersSupport {
    case selectItems
    
    static let allValues = ["Press"]
}

enum MakerFinder {
    case standard, anamorphic
    static let allValues = ["Standard","Anamprphic"]
}

class Maker {
    var makerCamera: MakerCamera
    var makerPrimes: MakerPrimes
    var makerMacros: MakerMacros
    var makerProbes: MakerProbe
    var makerAKSFiltersSupport: MakerAKSFiltersSupport
    
    init(makerCamera: MakerCamera, makerPrimes: MakerPrimes, makerMacros: MakerMacros, makerProbes: MakerProbe, makerAKSFiltersSupport: MakerAKSFiltersSupport ) {
        self.makerCamera = makerCamera
        self.makerPrimes = makerPrimes
        self.makerMacros = makerMacros
        self.makerProbes = makerProbes
        self.makerAKSFiltersSupport = makerAKSFiltersSupport
    }
}

func setCamModel(maker: MakerCamera) -> [String] {
    switch maker {
    case .arri:
        return ["Alexa", "Mini", "Amira"]
    case .red:
        return ["Dragon", "Weapon", "Epic"]
    case .phantom:
        return ["Flex 4k", "Flex", "HD Gold"]
    case .panavision:
        return ["Genesis", "Platinium", "Millenioum"]
    default:
        return  ["set cam model", "failed", "break"]
    }
}

func setPrimesModel(maker: MakerPrimes) -> [String] {
    switch maker {
    case .zeiss:
        return ["Master Primes", "Ultra Primes", "Super Speeds"]
    case .leica:
        return ["Summilux-C", "Summicron-C", "Telephoto"]
    case .canon:
        return ["K-35", "Telephoto"]
    case .cooke:
        return ["i5", "S4", "Speed Panchro"]
    }
}

func setMacrosModel(maker: MakerMacros) -> [String] {
    switch maker {
    case .arri:
        return ["Macro"]
    case .zeiss:
        return ["Master Primes"]
    }
}

func setProbeModel(maker: MakerProbe) -> [String] {
    switch maker {
    case .innovision:
        return ["Probe II+"]
    case .tRex:
        return ["Probe"]
    case .revolution:
        return ["Probe"]
    case .skater:
        return ["Scope"]
    case .century:
        return ["Periscope"]
    case .optex:
        return ["Excellence"]
    }
}

func setModelEmpty() -> [String] {
    return ["Add ⬇︎"]
}


/// print statement to examime objects
func youShoudSeeThis(say: String, see: AnyObject ) {
    
    print("\n\(say) \(see)")
    
}







