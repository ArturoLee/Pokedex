//
//  Pokemon.swift
//  pokedex
//
//  Created by Arturo Lee on 9/10/16.
//  Copyright © 2016 futw. All rights reserved.
//

import Foundation

class Pokemon {
    
    fileprivate var _name: String!
    fileprivate var _pokdexID: Int!
    
    var name: String {
        return _name
    }
    
    var pokdexId: Int {
        return _pokdexID
    }
    
    init(name: String, pokdexId: Int) {
        self._name = name
        self._pokdexID = pokdexId
    }
    
}
