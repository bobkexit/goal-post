//
//  CreateGoalVC.swift
//  goal-post
//
//  Created by Николай Маторин on 13.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit

class CreateGoalVC: UIViewController, UITextViewDelegate {
    
    // Outlets
    @IBOutlet weak var goalTextView: UITextView!
    @IBOutlet weak var shortTermBtn: UIButton!
    @IBOutlet weak var longTermBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    // Variables
    var goalType: GoalType = .shortTerm
    
    override func viewDidLoad() {
        super.viewDidLoad()

        nextBtn.bindToKeyboard()
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedClor()
        
        goalTextView.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == PH_GOALTEXTVIEW {
            textView.text = ""
            textView.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        }
    }

    @IBAction func nextBtnPressed(_ sender: Any) {
        if goalTextView.text != "" && goalTextView.text != PH_GOALTEXTVIEW {
            guard let finishGoalVC = storyboard?.instantiateViewController(withIdentifier: SB_FINISH_GOAL_VC) as? FinishGoalVC else { return }
            finishGoalVC.initData(desctription: goalTextView.text!, type: goalType)
            presentingViewController?.presentSecondaryDetail(finishGoalVC)
        }
    }
    
    @IBAction func shortTermBtnPressed(_ sender: Any) {
        goalType = .shortTerm
        shortTermBtn.setSelectedColor()
        longTermBtn.setDeselectedClor()
    }
    
    @IBAction func longTermBtnPressed(_ sender: Any) {
        goalType = .longTerm
        longTermBtn.setSelectedColor()
        shortTermBtn.setDeselectedClor()
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        //dismiss(animated: true, completion: nil)
        dismissDetail()
    }
    

}
