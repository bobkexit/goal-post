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
    @IBOutlet weak var completionView: UIView!
    
    func configureCell(goal: Goal) {
        goalDescriptionLbl.text = goal.goalDescription
        goalTypeLbl.text = goal.goalType
        goalProgressLbl.text = "\(goal.goalProgress)" //String(describing: progressAmount)
        
        completionView.isHidden = (goal.goalProgress != goal.goalCompletionValue)
    }

}
