//
//  Teams.swift
//  Bundesliga App
//
//  Created by Admin on 11/25/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import Foundation



class Teams {
    
    var teamName  : String
    var teamImage :String
    var  shortName : String
    
    var teamPlayersLink  :String
    
    init(teamName :String, teamImage :String ,  teamPlayersLink : String , shortName : String){
        
        self.teamName = teamName
        self.teamImage = teamImage
       self.teamPlayersLink = teamPlayersLink
        self.shortName = shortName
        
    }
    
    
    
}
