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
    case zeiss, leica, canon, cooke, vantage, bauschlomb, kowa, kineoptic, nikkor, red, camtec, anamorphic
    
    static let allValues = ["Zeiss","Leica","Canon","Cooke", "Vantage", "Bausch + Lomb", "Kowa",
                            "Kineoptic", "Nikkor", "Red", "CamTec", "Anamorphic"]
}

enum MakerMacros {
    case arri, zeiss
    
    static let allValues = ["Arri", "Zeiss"]
}

enum MakerProbe {
    case innovision, tRex, revolution, skater, century, optex
    
    static let allValues = ["Innovision", "T-Rex", "Revolution", "Skater", "Century", "Optex"]
}
/////////////////
enum MakerZoom {
    case angenieux, fujinon, cooke, zeissVP, hawk, century, canon, anamorphic
    static let allValues = ["Angenieux","Fujinon", "Cooke","Zeiss VP", "Hawk", "Century", "Canon","Anamorphic"]
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
    var makerZoom:   MakerZoom
    var makerAKSFiltersSupport: MakerAKSFiltersSupport
    var makerFinder: MakerFinder
    
    init(makerCamera: MakerCamera, makerPrimes: MakerPrimes, makerMacros: MakerMacros, makerProbes: MakerProbe, makerZoom: MakerZoom, makerAKSFiltersSupport: MakerAKSFiltersSupport, makerFinder: MakerFinder ) {
        self.makerCamera = makerCamera
        self.makerPrimes = makerPrimes
        self.makerMacros = makerMacros
        self.makerProbes = makerProbes
        self.makerZoom = makerZoom
        self.makerAKSFiltersSupport = makerAKSFiltersSupport
        self.makerFinder = makerFinder
    }
}

func setCamModel(maker: MakerCamera) -> [String] {
    switch maker {
    case .arri:
        return ["Mini", "Amira", "Alexa", "Alexa STX", "Alexa XT+","Alexa +XR","Alexa ST XR","Alexa M", "235", "535B", "435", "Arricam LT", "Arricam ST", "SR3", "416"]
    case .red:
        return ["Weapon", "Epic","Epic Dragon","One"]
    case .phantom:
        return ["Flex 4k", "Flex", "HD Gold"]
    case .panavision:
        return ["Genesis", "XL2", "Platinum", "Gold-G2", "Millennium"]
    case .sony:
        return ["F-55", "F-65", "F-5","F-S5","F-S7"]
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
    case .vantage:
        return  ["One"]
    case .bauschlomb:
        return ["Super Baltar"]
    case .kowa:
        return ["Cine Prominar"]
    case .kineoptic:
        return ["Apochromat"]
    case .nikkor:
        return  ["Telephoto"]
    case .red:
        return ["Pro"]
    case .camtec:
        return ["Ultra Primes"]
    case .anamorphic:
        return ["Cooke Vintage", "Cooke", "Master Primes", "Arriscope", "Kowa", "Hawk VL", "Hawk V", "Hawk C", "Cineovision"]
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
////////////// ["Angenieux","Fujinon", "Cooke","Zeiss VP", "Hawk", "Century", "Canon","Anamorphic" ]
func setZoomModel(maker: MakerZoom)-> [String] {
    switch maker {
    case .angenieux:
        return ["Probe II+"]
    case .fujinon:
        return ["Probe"]
    case .cooke:
        return ["Probe"]
    case .zeissVP:
        return ["Scope"]
    case .hawk:
        return ["Periscope"]
    case .century:
        return ["Excellence"]
    case .canon:
        return ["Periscope"]
    case .anamorphic:
        return ["Excellence"]
    }
}
func setModelEmpty() -> [String] {
    return ["Add ⬇︎"]
}

func setFinderModel(maker: MakerFinder) -> [String] {
    switch maker {
    case .standard:
        return ["Standard"]
    case .anamorphic:
        return ["Anamprphic"]

    }
}


/// print statement to examime objects
func youShoudSeeThis(say: String, see: AnyObject ) {
    
    print("\n\(say) \(see)")
    
}







