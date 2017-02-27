//
//  Unique Kits.swift
//  Camera Order Scout
//
//  Created by Warren Hansen on 2/25/17.
//  Copyright © 2017 Warren Hansen. All rights reserved.
//

import Foundation
import RealmSwift

class AksItem: Object {
    dynamic var detail = ""
    dynamic var status = false
}

class FilterItem: Object {
    dynamic var detail = ""
    dynamic var status = false
}

class SupportItem: Object {
    dynamic var detail = ""
    dynamic var status = false
}


class FirstRun { // aks filters support
    
    let realm = try! Realm()
    
    func populateRealmKits() {
        
        // load stock aks items
        let tableviewArrays = TableViewArrays()
        
        tableviewArrays.setPrimesKit(compState: [0,5,0,0])
        
        print("\nYou loaded AKS: \(tableviewArrays.thePrimes)\n")
        
        for  item in tableviewArrays.thePrimes {
            
            let aksItem = AksItem()
            aksItem.detail = item
            aksItem.status = false
            
            try! self.realm.write({
                self.realm.add(aksItem)
            })
        }
        
        // load stock filters
        tableviewArrays.setPrimesKit(compState: [0,7,0,0])
        
        print("\nYou loaded Filters: \(tableviewArrays.thePrimes)\n")
        
        for  item in tableviewArrays.thePrimes {
            
            let filterItem = FilterItem()
            filterItem.detail = item
            filterItem.status = false
            
            try! self.realm.write({
                self.realm.add(filterItem)
            })
        }
        
        // load stock support
        tableviewArrays.setPrimesKit(compState: [0,8,0,0])
        
        print("\nYou loaded Support: \(tableviewArrays.thePrimes)\n")
        
        for  item in tableviewArrays.thePrimes {
            
            let supportItem = SupportItem()
            supportItem.detail = item
            supportItem.status = false
            
            try! self.realm.write({
                self.realm.add(supportItem)
            })
        }
    }
}
