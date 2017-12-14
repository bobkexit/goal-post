//
//  GoalsVC.swift
//  goal-post
//
//  Created by Николай Маторин on 13.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit

class GoalsVC: UIViewController {
    
    // Outlets
    @IBOutlet weak var tableView: UITableView!
    
    
    // Variables
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.isHidden = false
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GoalDataService.instance.fetchGoals { (success) in
            if success {
                self.tableView.isHidden = (GoalDataService.instance.goals.count == 0)
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func goalBtnPressed(_ sender: Any) {
        guard let createGoalVS = storyboard?.instantiateViewController(withIdentifier: SB_GREATE_GOAL_VC) else { return }
        presentDetail(createGoalVS)
    }

}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GOAL_CELL, for: indexPath) as? GoalCell else { return UITableViewCell() }
        
        let goal = GoalDataService.instance.goals[indexPath.row]
        cell.configureCell(goal: goal)

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GoalDataService.instance.goals.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
       
        let deleteAction = UITableViewRowAction(style: .destructive, title: "DELETE") { (rowAction, indexPath) in
            let goal = GoalDataService.instance.goals[indexPath.row]
            GoalDataService.instance.removeGoal(goal: goal, completionHandler: { (success) in
                if success {
                    self.tableView.isHidden = (GoalDataService.instance.goals.count == 0)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            })
        }
        deleteAction.backgroundColor = #colorLiteral(red: 1, green: 0.1491314173, blue: 0, alpha: 1)
    
        let addProgressAction = UITableViewRowAction(style: .normal, title: "ADD 1") { (rowAction, indexPath) in
            let goal = GoalDataService.instance.goals[indexPath.row]
            GoalDataService.instance.updateProgress(ForGoal: goal, completionHandler: { (success) in
                self.tableView.reloadRows(at: [indexPath], with: .automatic)
            })
        }
        addProgressAction.backgroundColor = #colorLiteral(red: 0.9385011792, green: 0.7164435983, blue: 0.3331357837, alpha: 1)
        
        return [deleteAction, addProgressAction]
    }
}

