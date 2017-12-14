//
//  GoalCell.swift
//  goal-post
//
//  Created by Николай Маторин on 13.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {
    
    // Outlets
    @IBOutlet weak var goalDescriptionLbl: UILabel!
    @IBOutlet weak var goalTypeLbl: UILabel!
    @IBOutlet weak var goalProgressLbl: UILabel!
    
    func configureCell(description: String, type: GoalType, progressAmount: Int ) {
        goalDescriptionLbl.text = description
        goalTypeLbl.text = type.rawValue
        goalProgressLbl.text = "\(progressAmount)" //String(describing: progressAmount)
    }

}
