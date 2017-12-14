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
    
    @IBAction func goalBtnPressed(_ sender: Any) {
    }
}

extension GoalsVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GOAL_CELL, for: indexPath) as? GoalCell else { return UITableViewCell() }
        cell.configureCell(description: "Eat salad twice a week.", type: .shortTerm, progressAmount: 2)

        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}

