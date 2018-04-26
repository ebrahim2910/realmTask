//
//  TeamDataBaseModel.swift
//  Bundesliga App
//
//  Created by Admin on 11/27/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class  TeamDataBaseModel : Object {
    
    dynamic var teamNameDataBase : String?
    
    dynamic var shortName : String?
    
    
    
    override class func primaryKey() -> String? {
        return "shortName"
    }
}
