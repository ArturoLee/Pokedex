//
//  Pokemon.swift
//  pokedex
//
//  Created by Arturo Lee on 9/10/16.
//  Copyright © 2016 futw. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name: String!
    private var _pokdexID: Int!
    private var _description: String!
    private var _type: String!
    private var _defense: String!
    private var _height: String!
    private var _weight: String!
    private var _attack: String!
    private var _nextEvolutionTxt: String!
    private var _nextEvolutionName: String!
    private var _nextEvoId: String!
    private var _nextEvoLevel: String!
    private var _pokemonURL: String!
    
    //Getters
    //Protect the data and make sure we are only providing an actual value or an empty string if the value is nil.
    
    var nextEvolevel: String {
        if _nextEvoLevel == nil {
            return ""
        }
        return _nextEvoLevel
    }
    var nextEvolutionName: String {
        if _nextEvolutionName == nil {
            return ""
        }
        return _nextEvolutionName
    }
    
    var nextEvoId: String {
        if _nextEvoId == nil {
            return ""
        }
        return _nextEvoId
    }
    
    var description: String {
        if _description == nil {
            return ""
        }
        return _description
    }
    var type: String {
        if _type == nil {
            return ""
        }
        return _type
    }
    var defense: String {
        if _defense == nil {
            return ""
        }
        return _defense
    }
    var height: String {
        if _height == nil {
            return ""
        }
        return _height
    }
    var weight: String {
        if _weight == nil {
            return ""
        }
        return _weight
    }
    var attack: String {
        if _attack == nil {
            return ""
        }
        return _attack
    }
    var nextEvolutionTxt: String {
        if _nextEvolutionTxt == nil {
            return ""
        }
        return _nextEvolutionTxt
    }
    
    var name: String {
        return _name
    }
    
    var pokdexId: Int {
        return _pokdexID
    }
    
    init(name: String, pokdexId: Int) {
        self._name = name
        self._pokdexID = pokdexId
        
        self._pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self.pokdexId)/"
    }
    
    func downloadPokemonDetail(completed: @escaping DownloadComplete) {
        Alamofire.request(_pokemonURL, method: .get).responseJSON { (response) in
            
            //JSON Data
            if let dict = response.result.value as? Dictionary<String, AnyObject>{
                if let weight = dict["weight"] as? String {
                    self._weight = weight
                }
                
                if let height = dict["height"] as? String {
                    self._height = height
                }
                
                if let attack = dict["attack"] as? Int {
                    self._attack = "\(attack)"
                }
                
                if let defense = dict["defense"] as? Int {
                    self._defense = "\(defense)"
                }
                
                if let types = dict["types"] as? [Dictionary<String, String>] , types.count > 0 {
                    
                    if let name = types[0]["name"] {
                        self._type = name.capitalized
                    }
                    
                    if types.count > 1 {
                        for x in 1..<types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalized)"
                            }
                        }
                    }
                }
                
                if let descriptions = dict["descriptions"] as? [Dictionary<String, String>], descriptions.count > 0 {
                    
                    if let firstDescriptionURL = descriptions[0]["resource_uri"] {
                        let url = "\(URL_BASE)\(firstDescriptionURL)"
                        
                        Alamofire.request(url, method: .get).responseJSON { (response) in
                            
                            if let dict = response.result.value as? Dictionary<String, AnyObject> {
                                if let descrip = dict["description"] as? String {
                                    
                                    let newDescrip = descrip.replacingOccurrences(of: "POKMON", with: "Pokemon")
                                    self._description = newDescrip
                                }
                            }
                            completed()
                        }
                    }
                } else {
                    self._description = ""
                }
                
                if let evolutions = dict["evolutions"] as? [Dictionary<String, AnyObject>], evolutions.count > 0 {
                    
                    if let evo = evolutions[0]["to"] as? String {
                        if evo.range(of: "mega") == nil{
                            self._nextEvolutionName = evo
                            if let evoURL = evolutions[0]["resource_uri"] as? String {
                                var pokeId = evoURL.replacingOccurrences(of: "/api/v1/pokemon/", with: "")
                                pokeId = pokeId.replacingOccurrences(of: "/", with: "")
                                self._nextEvoId = pokeId
                            
                                if let nxtLvlExist = evolutions[0]["level"] {
                                    
                                    if let lvl = nxtLvlExist as? Int {
                                        self._nextEvoLevel = "\(lvl)"
                                    }
                                } else {
                                    self._nextEvoLevel = ""
                                }
                            }
                        }
                    }
                }
            }
            
            completed()//Letting the function know that it is completed
            //@escaping needs to be added to function
        }
    }
    
}
