//
//  TeamsTableViewCell.swift
//  Bundesliga App
//
//  Created by Admin on 11/25/17.
//  Copyright © 2017 ITI. All rights reserved.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {
    
    
    
    @IBOutlet weak var webView: UIWebView!
   
    

    @IBOutlet weak var teamName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
