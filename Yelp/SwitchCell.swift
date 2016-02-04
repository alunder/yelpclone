//
//  SwitchCell.swift
//  Yelp
//
//  Created by user on 2/3/16.
//  Copyright © 2016 Timothy Lee. All rights reserved.
//

import UIKit

class SwitchCell: UITableViewCell {

    @IBOutlet weak var onSwitch: UISwitch!
    @IBOutlet weak var switchLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    onSwitch.addTarget(self, action: "", forControlEvents: UIControlEvents.ValueChanged)
    }
    
 

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        func switchValueChanged() {
            print("switch Value Changed")
        }

        // Configure the view for the selected state
    }

}
