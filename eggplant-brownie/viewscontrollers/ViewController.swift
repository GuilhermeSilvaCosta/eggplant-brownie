//
//  ViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Costa on 28/12/19.
//  Copyright © 2019 Guilherme Costa. All rights reserved.
//

import UIKit

protocol AddAMealDelegate {
    func add(meal: Meal)
}

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, AddAnItemDelegate {

    @IBOutlet var nameField: UITextField!
    @IBOutlet var happinessField: UITextField!
    @IBOutlet var tableView: UITableView?
    
    var delegate:AddAMealDelegate?
    
    var items = [Item(name: "Eggplant Brownie", calories: 10), Item(name: "Zucchini Muffin", calories: 10),
                 Item(name: "Cookie", calories: 10),
                 Item(name: "Coconut oil", calories: 500),
                 Item(name: "Chocolate frosting", calories: 1000),
                 Item(name: "Chocolate chip", calories: 1000)]
    var selected = Array<Item>()
    
    override func viewDidLoad() {
        let newItemButton = UIBarButtonItem(title: "new item",
                                            style: UIBarButtonItem.Style.plain,
                                            target: self,
                                            action: Selector("showNewItem"))
        navigationItem.rightBarButtonItem = newItemButton
    }
    
    func addNew(item: Item) {
        items.append(item)
        if tableView == nil {
            return
        }
        tableView!.reloadData()
    }
    
    @IBAction func showNewItem() {
        let newItem = NewItemViewController(delegate: self)
        if let navigation = navigationController {
            navigation.pushViewController(newItem, animated: true)
        }
    }
    
    @IBAction func add() {
        if nameField == nil || happinessField == nil {
            return
        }
        let name = nameField!.text
        let happiness: Int? = Int(happinessField.text!)
        if happiness == nil {
            return
        }
        let meal = Meal(name: name!, happiness: happiness!)
        meal.items = selected
        print("eaten: \(meal.name) \(meal.happiness) \(meal.items)")
        
        if delegate == nil {
            return
        }
        
        delegate!.add(meal: meal)
        
        if let navigation = self.navigationController {
            navigation.popViewController(animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let row = indexPath.row
        let item = items[ row ]
        var cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: nil)
        cell.textLabel?.text = item.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if cell == nil {
            return
        }
        if cell!.accessoryType == UITableViewCell.AccessoryType.none {
            cell!.accessoryType = UITableViewCell.AccessoryType.checkmark
            selected.append(items[indexPath.row])
        } else {
            cell!.accessoryType = UITableViewCell.AccessoryType.none
            if let position = find(elements: selected, toFind: items[indexPath.row]) {
                selected.remove(at: position)
            }
        }
    }
    
    func find(elements:Array<Item>, toFind:Item) -> Int? {
        let max = elements.count - 1
        for i in 0...max {
            if toFind == elements[i] {
                return i
            }
        }
        return nil
        
    }

}

