//
//  MealsTableViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Costa on 09/01/20.
//  Copyright © 2020 Guilherme Costa. All rights reserved.
//

import UIKit

class MealsTableViewController: UITableViewController, AddAMealDelegate {
    
    var meals = [ Meal(name: "Eggplant brownie", happiness: 5), Meal(name: "Zucchini Muffin", happiness: 3)];
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "addMeal") {
            let view = segue.destination as! ViewController
            view.delegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return meals.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let meal = meals[ row ]
        
        var cell = UITableViewCell(
            style: UITableViewCell.CellStyle.default,
            reuseIdentifier: nil)
        
        cell.textLabel?.text = meal.name
        
        let longPress = UILongPressGestureRecognizer(target: self, action: Selector("showDetails:"))
        return cell
    }
    
    func add(meal: Meal) {
        meals.append(meal)
        tableView.reloadData()
    }
    
    func showDetails(recognizer: UILongPressGestureRecognizer) {
        if recognizer.state == UIGestureRecognizer.State.began {
            let cell = recognizer.view
            let indexPath = tableView.indexPath(for: cell as! UITableViewCell)
            if indexPath == nil {
                return
            }
            let row = indexPath!.row
            let meal = meals[ row ]
            
            func removeSelected(action: UIAlertAction) {
                meals.remove(at: row)
                tableView.reloadData()
            }
            
            let details = UIAlertController(title: meal.name, message: meal.details(), preferredStyle: UIAlertController.Style.alert)
            let remove = UIAlertAction(title: "Remove", style: UIAlertAction.Style.destructive, handler: removeSelected)
            details.addAction(remove)
            let cancel = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil)
            details.addAction(cancel)
            present(details, animated: true, completion: nil)
        }
    }
    
    
}
