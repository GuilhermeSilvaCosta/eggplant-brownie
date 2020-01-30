//
//  NewItemViewController.swift
//  eggplant-brownie
//
//  Created by Guilherme Costa on 30/01/20.
//  Copyright © 2020 Guilherme Costa. All rights reserved.
//

import UIKit

protocol AddAnItemDelegate {
    func addNew(item:Item)
}

class NewItemViewController: UIViewController {

    let delegate:AddAnItemDelegate?
    init(delegate:AddAnItemDelegate) {
        self.delegate = delegate
        super.init(nibName: "NewItemViewController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet var nameField:UITextField?
    @IBOutlet var caloriesField:UITextField?
    
    @IBAction func addNewItem() {
        if nameField == nil || caloriesField == nil {
            return
        }
        
        let name = nameField!.text
        let calories = NSString(string: caloriesField!.text!).doubleValue
        
        let item = Item(name: name!, calories: calories)
        
        if delegate == nil {
            return
        }
        
        delegate!.addNew(item: item)
        
        if let navigation = navigationController {
            navigation.popViewController(animated: true)
        }
    }

}
