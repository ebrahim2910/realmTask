//
//  PlayersTableViewCell.swift
//  Bundesliga App
//
//  Created by Admin on 11/25/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import UIKit

class PlayersTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var playerName: UILabel!
    

    @IBOutlet weak var playerPosition: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
