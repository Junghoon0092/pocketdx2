//
//  Pokemon.swift
//  pocketmon
//
//  Created by Junghoon on 2016. 5. 5..
//  Copyright © 2016년 Junghoon. All rights reserved.
//

import Foundation


class Pokemon {
    
    private var _name : String!
    private var _pokedexId : Int!
    
    
    var name : String {
        return _name
    }
    
    var pokedexId : Int {
        return _pokedeId
    }
    
    
    init(name: String, pokedexId:Int ) {
        
        self._name = name
        self._pokedexId = pokedexId
        
    }
    
}