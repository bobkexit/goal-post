//
//  GoalDataService.swift
//  goal-post
//
//  Created by Николай Маторин on 14.12.2017.
//  Copyright © 2017 Николай Маторин. All rights reserved.
//

import UIKit
import CoreData

class GoalDataService {
    static let instance = GoalDataService()
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    var goals = [Goal]()
    
    func createGoal(description:  String, type: GoalType, completionValue: Int32, completionHandler: @escaping CompletionHandler) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let goal = Goal(context: managedContext)
        goal.goalDescription = description
        goal.goalType = type.rawValue
        goal.goalCompletionValue = completionValue
        goal.goalProgress = 0

        do {
            try managedContext.save()
            completionHandler(true)
        } catch {
            debugPrint("Could not save: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
    
    func fetchGoals(completionHandler: @escaping CompletionHandler) {
       
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        let fetchRequest = NSFetchRequest<Goal>(entityName: ENTITY_GOAL)
        
        do {
            goals = try managedContext.fetch(fetchRequest)
            completionHandler(true)
        } catch  {
            debugPrint("Could not fetch: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
    
    func removeGoal(goal: Goal, completionHandler: @escaping CompletionHandler) {
        
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        managedContext.delete(goal)
    
        do {
            try managedContext.save()
            fetchGoals(completionHandler: { (success) in
                completionHandler(success)
            })
        } catch {
            debugPrint("Could not remove data: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
    
    func updateProgress(ForGoal goal: Goal, completionHandler: @escaping CompletionHandler) {
        guard let managedContext = appDelegate?.persistentContainer.viewContext else {
            return
        }
        
        if goal.goalProgress == goal.goalCompletionValue {
            return
        }
        
        goal.goalProgress += 1
        
        do {
            try managedContext.save()
            completionHandler(true)
        } catch  {
            debugPrint("Could not set progress: \(error.localizedDescription)")
            completionHandler(false)
        }
    }
}
