//
//  Players.swift
//  Bundesliga App
//
//  Created by Admin on 11/25/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import Foundation

class Players {
    
    var playerName  : String
    var playerPosition :String
    
    
    
    init(playerName :String, playerPosition :String ){
        
        self.playerName = playerName
        self.playerPosition = playerPosition
        
        
    }
    
    
    var titleFirstLetter: String {
        return String(self.playerName[self.playerName.startIndex]).uppercased()
    }
}
