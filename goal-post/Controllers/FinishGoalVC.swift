//
//  FinishGoalVC.swift
//  goal-post
//
//  Created by Николай Маторин on 14.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var createGoalBtn: UIButton!
    @IBOutlet weak var pointsTextField: UITextField!
    
    // Variables
    var goalDescription: String!
    var goalType: GoalType!
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    func initData(desctription: String, type: GoalType) {
        self.goalDescription = desctription
        self.goalType = type
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        createGoalBtn.bindToKeyboard()
    }

    @IBAction func createGoalBtnPressed(_ sender: Any) {
        if pointsTextField.text != "" {
            GoalDataService.instance.createGoal(description: goalDescription, type: goalType, completionValue: Int32(pointsTextField.text!)!, completionHandler: { (success) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                }
            })
        }
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismissDetail()
    }
}
