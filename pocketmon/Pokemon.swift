//
//  Pokemon.swift
//  pocketmon
//
//  Created by Junghoon on 2016. 5. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation
import Alamofire

class Pokemon {
    
    private var _name : String!
    private var _pokedexId : Int!
    private var _description : String!
    private var _type : String!
    private var _defense : String!
    private var _height : String!
    private var _weight : String!
    private var _attack : String!
    private var _nextEvlutionTxt : String!
    private var _nextEvlutionId : String!
    private var _nextEvlutionLV : String!
    private var _pokemonURL : String!
    

 
    
    var pokemonURL : String {
        return _pokemonURL
    }
    
    var nextEvlutionLV : String {
        if _nextEvlutionLV == nil {
            _nextEvlutionLV = ""
        }
        return _nextEvlutionLV
    }



    var nextEvlutionId : String {
        if _nextEvlutionId == nil {
            _nextEvlutionId = ""
        }
        return _nextEvlutionId
    }
    
    var nextEvlutionTxt : String {
        if _nextEvlutionTxt == nil {
            _nextEvlutionTxt = ""
        }
        return _nextEvlutionTxt
    }
    
    var attack : String {
        if _attack == nil {
            _attack = ""
        }
        return _attack
    }
    
    var weight : String {
        if _weight == nil {
            _weight = ""
        }
        return _weight
    }
    
    var height : String {
        if _height == nil {
            _height = ""
        }
        return _height
    }
    
    
    var defense : String {
        if _defense == nil {
            _defense = ""
        }
        return _defense
    }
    
    var type : String {
        if _type == nil {
            _type = ""
        }
        return _type
    }
    
    var description : String {
        if _description == nil {
            _description = ""
        }
        return _description
    }
    
    var name : String {
        return _name
    }
    
    var pokedexId : Int {
        return _pokedexId
    } 
    
    init(name: String, pokedexId:Int ) {
        
        self._name = name
        self._pokedexId = pokedexId
    
        _pokemonURL = "\(URL_BASE)\(URL_POKEMON)\(self._pokedexId)/"
    }
    
    func downloadPokemonDetails(completed: DownloadComplete) {
     
        let url = NSURL(string: _pokemonURL)
        Alamofire.request(.GET, url!).responseJSON { Response in
            let result = Response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
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
                
                if let types = dict["types"] as? [Dictionary<String,String>] where types.count > 0 {
                    if let name = types[0]["name"] {
                        self._type = name.capitalizedString
                    }
                    
                    if types.count > 1 {
                        for x in 1 ..< types.count {
                            if let name = types[x]["name"] {
                                self._type! += "/\(name.capitalizedString)"
                            }
                        }
                    }
                } else {
                    self._type = ""
                }
                
                if let descArr = dict["descriptions"] as? [Dictionary<String,String>] where descArr.count > 0
                {
                    if let url = descArr[0]["resource_url"] {

                        let nsurl = NSURL(string: "\(URL_BASE)\(url)")!
                        Alamofire.request(.GET, nsurl).responseJSON
                            { Response in
                            let desresult = Response.result
                            if let descDict = desresult.value as? Dictionary<String, AnyObject>
                            {
                                if let description = descDict["description"] as? String
                                {
                                    self._description = description
                                    
                                }
                            }
                            completed()
                        }
                    }else {
                        self._description = ""
                    }
                
                    if let evoltutions = dict["evolutions"] as? [Dictionary<String, AnyObject>] where evoltutions.count > 0 {
                    
                        if let to = evoltutions[0]["to"] as? String {
                            if to.rangeOfString("mega") == nil {
                                
                                if let uri = evoltutions[0]["resource_uri"] as? String {
                                    let newStr = uri.stringByReplacingOccurrencesOfString("/api/v1/pokemon", withString: "")
                                    
                                    let num = newStr.stringByReplacingOccurrencesOfString("/", withString: "")
                                    
                                    self._nextEvlutionId = num
                                    self._nextEvlutionTxt = to

                                    
                                    if let lvl = evoltutions[0]["level"] as? Int {
                                        self._nextEvlutionLV = "\(lvl)"
                                    }
                                    
                                    
                                }
                            }
                        }
                    }
                    
                }
            
            
        }
        
    }
}
}